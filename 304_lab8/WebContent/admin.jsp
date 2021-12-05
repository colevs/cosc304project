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
                con.close();
            } catch (SQLException ex) 
            { 	out.println(ex); 
            }

%>

</body>
<h1 style="color: red;">Reset Database</h1>
<h4><a href="loaddata.jsp">Reset Database</a></h4>
<p style="color:blue">Warning! This will reset the database</p>
</html>

