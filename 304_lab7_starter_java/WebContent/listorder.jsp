<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<title>Bigtime Grocery Order List</title>
<style>
table, th, td {
  border:1px solid black;
}
</style>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";

// Make connection
	try (Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();
	Statement stmt1 = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);) {

// Write query to retrieve all order summary records
	ResultSet rst = stmt.executeQuery("SELECT orderId, orderDate, customer.customerId AS customerId, firstName, lastName, totalAmount FROM ordersummary JOIN customer ON customer.customerId = ordersummary.customerId");	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
	ResultSet rst1 = stmt1.executeQuery("SELECT productId, orderId, quantity, price FROM orderproduct");
// For each order in the ResultSet
	out.println("<table>");
	out.println("<tr>");
		out.println("<th>Order ID</th>");
		out.println("<th>Order Date</th>");
		out.println("<th>Customer ID</th>");
		out.println("<th>Customer Name</th>");
		out.println("<th>Total Amount</th>");		
	out.println("</tr>");
	while (rst.next()) {
		out.println("<tr>");
			out.println("<td>" + rst.getInt("orderId") + "</td>");
			out.println("<td>" + rst.getDate("orderDate") + " " + rst.getTime("orderDate") + "</td>");
			out.println("<td>" + rst.getInt("customerId") + "</td>");
			out.println("<td>" + rst.getString("firstName") + " " + rst.getString("lastName") + "</td>");
			out.println("<td>" + currFormat.format(rst.getBigDecimal("totalAmount")) + "</td>");
			boolean flag = true;
			while(rst1.next()) {
				if(flag) {
					out.println("<tr align='right'>");
					out.println("<td colspan='5'>");
					out.println("<table>");
					out.println("<th>Product Id</th>");
					out.println("<th>Quantity</th>");
					out.println("<th>Price</th>");
					out.println("</td>");
					flag = false;
				}
				if(rst.getInt("orderId") == rst1.getInt("orderId")) {
						out.println("<tr>");
							out.println("<td>" + rst1.getInt("productId") + "</td>");
							out.println("<td>" + rst1.getInt("quantity") + "</td>");
							out.println("<td>" + currFormat.format(rst1.getBigDecimal("price")) + "</td>");
						out.println("</tr>");
				}				
			}
			out.println("</table>");
			out.println("</td>");
			out.println("</tr>");			
			out.println("<tr>");
			out.println("</tr>");
			rst1.beforeFirst();
		out.println("</tr>");
	}
	out.println("</table>");

// Close connection
	con.close();
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
%>

</body>
</html>

