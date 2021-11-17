<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
</head>
<body>

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
String query = "SELECT productName, productId, productPrice FROM product WHERE productName LIKE ?";
PreparedStatement pStatement = null;

// Make the connection
try (Connection con = DriverManager.getConnection(url, uid, pw);) {
	if (name == null) name = "";
	PreparedStatement pstmt = null;
	ResultSet rst = null;
	pstmt = con.prepareStatement(query);
	pstmt.setString(1, "%"+name+"%");
	rst = pstmt.executeQuery();


// Print out the ResultSet
	DecimalFormat currFormat = new DecimalFormat("##.00");
	//NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	
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
		String link = "addcart.jsp?id="+productId+"&name="+productName+"&price="+Double.toString(productPrice);
		out.println("<tr><td><a href="+link+">Add to Cart</a></td>"
			+"<td>"+productName+"</td>"
			+"<td>$"+currFormat.format(productPrice)+"</td></tr>");
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