<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%
// Include files auth.jsp and jdbc.jsp
// TODO: Write SQL query that prints out total order amount by day
String userName = (String) session.getAttribute("authenticatedUser");
if(userName == null) {
    out.println("<h1>Access Denied</h1>");
    out.println("<h4><a href=\"index.jsp\">Index</a></h4>");
    out.println("<h4><a href=\"login.jsp\">Login</a></h4>");
} else {
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";
    try ( Connection con = DriverManager.getConnection(url, uid, pw);
			Statement stmt = con.createStatement();) 	{
                NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
                ResultSet rst = stmt.executeQuery("SELECT orderDate, totalAmount FROM ordersummary ORDER BY orderDate");
                out.println("<table class=\"table\" border=\"1\">");
                    out.println("<tr>");
                        out.println("<th>Order Date</th>");
                        out.println("<th>Total Order Amount</th>");
                    out.println("</tr>");
                while(rst.next()) {
                    out.println("<tr>");
                        out.println("<td>" + rst.getDate("orderDate") + "</td>");
                        out.println("<td>" + currFormat.format(rst.getBigDecimal("totalAmount")) + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");

                out.println("<h3>List Of Customer</h3>");
                rst = stmt.executeQuery("SELECT * FROM customer");
                out.println("<table class=\"table\" border=\"1\">");
                    out.println("<tr>");
                        out.println("<th>Customer ID</th>");
                        out.println("<th>First Name</th>");
                        out.println("<th>Last Name</th>");
                        out.println("<th>Email</th>");
                        out.println("<th>Phone Number</th>");
                        out.println("<th>Address</th>");
                        out.println("<th>City</th>");
                        out.println("<th>State</th>");
                        out.println("<th>Postal Code</th>");
                        out.println("<th>Country</th>");
                        out.println("<th>User ID</th>");
                        out.println("</tr>");
                while(rst.next()) {
                    out.println("<tr>");
                        out.println("<td>" + rst.getInt(1) + "</td>");
                        out.println("<td>" + rst.getString(2) + "</td>");
                        out.println("<td>" + rst.getString(3) + "</td>");
                        out.println("<td>" + rst.getString(4) + "</td>");
                        out.println("<td>" + rst.getString(5) + "</td>");
                        out.println("<td>" + rst.getString(6) + "</td>");
                        out.println("<td>" + rst.getString(7) + "</td>");
                        out.println("<td>" + rst.getString(8) + "</td>");
                        out.println("<td>" + rst.getString(9) + "</td>");
                        out.println("<td>" + rst.getString(10) + "</td>");
                        out.println("<td>" + rst.getString(11) + "</td>");

                    out.println("</tr>");
                }
                out.println("</table>");
                
                out.println("<h3>Warning! Will reset database</h3>");
                out.println("<h4><a href=\"loaddata.jsp\">Reset Database</a></h4>");

                con.close();
            } catch (SQLException ex) 
            { 	out.println(ex); 
            }
        }
%>

</body>

</html>

