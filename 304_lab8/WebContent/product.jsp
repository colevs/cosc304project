<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Locale" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>



<%@ include file="header.jsp" %>

<%
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

String sql = "SELECT productName, productPrice, productImageURL FROM product WHERE productId=?";

try (Connection con = DriverManager.getConnection(url, uid, pw);) {
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

	// Get product name to search for
	// TODO: Retrieve and display info for the product
	String productId = request.getParameter("id");

	PreparedStatement pstmt = null;
	ResultSet rst = null;
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(productId));
	rst = pstmt.executeQuery();

	rst.next();
	String productName = rst.getString(1);
	double productPrice = rst.getDouble(2);
	String productImageURL = rst.getString(3);


	out.println("<h2>"+productName+"</h2>");
	out.println("<table><tr>");
	out.println("<th>Id</th><td>"+productId+"</td></tr><tr><th>Price</th><td>"+currFormat.format(productPrice)+"</td></tr>");


	// TODO: If there is a productImageURL, display using IMG tag
	if(productImageURL != null) {
		out.println("<img src="+productImageURL+">");
	}
	
			
	// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
			

	out.println("</table>");
	// TODO: Add links to Add to Cart and Continue Shopping
	String addCartLink = "\"addcart.jsp?id="+Integer.parseInt(productId)+"&name="+productName+"&price="+productPrice+"\"";
	String continueShoppingLink = "\"listprod.jsp\"";

	out.println("<h3><a href="+addCartLink+">Add to Cart</a></h3>");
	out.println("<h3><a href="+continueShoppingLink+">Continue Shopping</a></h3>");
}
%>

</body>
</html>

