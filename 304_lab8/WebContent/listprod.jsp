<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
	<title>Bigtime Grocery</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<style>
	    th, td, a {
	        padding: 5px;
	    }
	    td {
	    	border:1px solid black;
	    }
	</style>
</head>
<body>

<div align="right" class="topnav">
    <a href="listprod.jsp">Begin Shopping</a>
    <a href="listorder.jsp">List All Orders</a>
    <a href="customer.jsp">Customer Info</a>
    <a href="admin.jsp">Administrators</a>
<%
if(session.getAttribute("authenticatedUser") != null) {
    out.println("<b>Signed in as: " + session.getAttribute("authenticatedUser") + "</b>");
}
if(session.getAttribute("authenticatedUser") != null) {
    out.println("<a href=\"logout.jsp\">Log out</a>");
} else {
    out.println("<a href=\"login.jsp\">Log in</a>");
}
%>
</div>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
Integer customerId = null;
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!
String productListQuery = "SELECT productName, productId, productPrice, productImageURL FROM product WHERE productName LIKE ?";
PreparedStatement pStatement = null;

String categoryPopularityQuery = null;

// Make the connection
try (Connection con = DriverManager.getConnection(url, uid, pw);) {
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
	

	if (name == null) name = "";
	PreparedStatement pstmt = null;
	ResultSet rst = null;
	pstmt = con.prepareStatement(productListQuery);
	pstmt.setString(1, "%"+name+"%");
	rst = pstmt.executeQuery();


// Print out the ResultSet
	

	if (name == "") {
		
		// If user is logged in and has made orders, recommend items from top 3 categories for the given user
		if(session.getAttribute("authenticatedUser") != null) {
			String custIdQuery = "SELECT customerId FROM customer WHERE userid = " + "\'"+session.getAttribute("authenticatedUser")+"\'";
			PreparedStatement pstmt1 = con.prepareStatement(custIdQuery);
	        ResultSet rst1 = pstmt1.executeQuery();
	        rst1.next();
	        customerId = rst1.getInt(1);

	        String productFromOrderQuery = "SELECT COUNT(*) as categoryCount "+
	        	"FROM product JOIN orderproduct ON product.productId = orderproduct.productId WHERE orderproduct.orderId IN "+
	        		"(SELECT orderId FROM ordersummary WHERE customerId = "+customerId+") "+
	        	"GROUP BY categoryId ORDER BY categoryCount DESC";

			PreparedStatement pstmt2 = con.prepareStatement(productFromOrderQuery);
	        ResultSet rst2 = pstmt2.executeQuery();
	        boolean hasRecommended = false;

	        ArrayList<Object[]> recommendedItems = new ArrayList<Object[]>();
	        for(int i = 0; i < 3; i++) {
	        	if (rst2.next()) {
	        		hasRecommended = true;
	        		String productsByCategory = "SELECT productName, productId, productPrice, productImageURL "+
	        			"FROM product "+
	        			"WHERE categoryId = " + rst2.getInt(1);

	        		PreparedStatement pstmt3 = con.prepareStatement(productsByCategory);
	        		ResultSet rst3 = pstmt3.executeQuery();

	        		while (rst3.next()) {
	        			Object[] productValues = {rst3.getString(1), rst3.getInt(2), rst3.getFloat(3), rst3.getString(4)};
	        			recommendedItems.add(productValues);
	        		}


	        	}
	        }
	        if (hasRecommended) {
	        	out.println("<h2>Recommended Products</h2>");
				out.println("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");
					for (int i = 0; i < recommendedItems.size(); i++) {
						//out.println(recommendedItems[i]);
						int productId = (int)recommendedItems.get(i)[1];
						String productName = (String)recommendedItems.get(i)[0];
						float productPrice = (float)recommendedItems.get(i)[2];
						String imgUrl = (String)recommendedItems.get(i)[3];

						String addCartLink = "\"addcart.jsp?id="+productId+"&name="+productName+"&price="+Double.toString(productPrice)+"\"";
						String productPageLink = "\"product.jsp?id="+productId+"\"";

						out.println("<tr><td><a href="+addCartLink+">Add to Cart</a></td>"
							+"<td><a href="+productPageLink+">"+productName+"</a></td>"
							+"<td>"+currFormat.format(productPrice)+"</td>"
							+"<td><img src="+imgUrl+" height=\"100\"></td></tr>");
					}
				out.println("</table><br />");

	        }
	        
		}
		out.println("<h2>All Products</h2>");

	} else {
		out.println("<h2>Products containing '"+name+"'</h2>");
	}
	out.println("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");
	while (rst.next()) {
		String productName = rst.getString(1);
		int productId = rst.getInt(2);
		double productPrice = rst.getDouble(3);
		String imgUrl = rst.getString(4);

		String addCartLink = "\"addcart.jsp?id="+productId+"&name="+productName+"&price="+Double.toString(productPrice)+"\"";
		String productPageLink = "\"product.jsp?id="+productId+"\"";

		out.println("<tr><td><a href="+addCartLink+">Add to Cart</a></td>"
			+"<td><a href="+productPageLink+">"+productName+"</a></td>"
			+"<td>"+currFormat.format(productPrice)+"</td>"
			+"<td><img src="+imgUrl+" height=\"100\"></td></tr>");

		/*out.println("<tr><td><a href="+addCartLink+">Add to Cart</a></td>"
			+"<td>"+productName+"</td>"
			+"<td>"+currFormat.format(productPrice)+"</td></tr>");*/
	}
	out.println("</table>");
	con.close();
// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
}
%>

</body>
</html>