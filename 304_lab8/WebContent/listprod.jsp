<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<title>Bigtime Grocery</title>
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
String productListQuery = "SELECT productName, productId, productPrice FROM product WHERE productName LIKE ?";
PreparedStatement pStatement = null;

String categoryPopularityQuery = null;

// Make the connection
try (Connection con = DriverManager.getConnection(url, uid, pw);) {
	if (name == null) name = "";
	PreparedStatement pstmt = null;
	ResultSet rst = null;
	pstmt = con.prepareStatement(productListQuery);
	pstmt.setString(1, "%"+name+"%");
	rst = pstmt.executeQuery();


// Print out the ResultSet
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
	
	if (name == "") {
		out.println("<h2>All Products</h2>");
	} else {
		out.println("<h2>Products containing '"+name+"'</h2>");
	}
	out.println("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");
	while (rst.next()) {
		String productName = rst.getString(1);
		int productId = rst.getInt(2);
		double productPrice = rst.getDouble(3);

		String addCartLink = "\"addcart.jsp?id="+productId+"&name="+productName+"&price="+Double.toString(productPrice)+"\"";
		String productPageLink = "\"product.jsp?id="+productId+"\"";

		out.println("<tr><td><a href="+addCartLink+">Add to Cart</a></td>"
			+"<td><a href="+productPageLink+">"+productName+"</a></td>"
			+"<td>"+currFormat.format(productPrice)+"</td></tr>");

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