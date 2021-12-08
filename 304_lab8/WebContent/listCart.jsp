<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
</head>
<body>

    <%
    try {
	    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    } catch (java.lang.ClassNotFoundException e) {
	    out.println("ClassNotFoundException: " + e);
    }

    String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";
    try ( Connection con = DriverManager.getConnection(url, uid, pw);
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            Statement stmt1 = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);) 	{
                NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
                String sqlSelect = "SELECT * FROM incart";
                ResultSet rst = stmt.executeQuery(sqlSelect);
                String sqlInsert1 = "SELECT orderId FROM incart";
                ResultSet rst1 = stmt1.executeQuery(sqlInsert1);
                if (rst.next() == true) {
                    rst.beforeFirst();
                    out.println("<table>");
                    int flag = 0;
                    while(rst.next()) {
                        out.println("<tr>");
                        out.println("<th>");
                            if(rst.getInt(1) != flag) {
                                out.println("<h2> Cart For Oder ID:  " + rst.getInt(1) + "</h2>");
                            }
                        out.println("</th>");
                        out.println("</tr>");
                        out.println("<tr>");
                            out.println("<td>");
                                out.println("<h3> Product ID: " + rst.getInt(2) + " Quantity: " + rst.getInt(3) + " Price: " + currFormat.format(rst.getInt(4)) + "</h3>");             
                            out.println("</td>");
                        out.println("</tr>");
                        flag = rst.getInt(1);
                }
                out.println("</table>");
            } else {
                out.println("<h1>Sorry, No Carts found</h1>");
                out.println("<h4><a href=\"index.jsp\">Index</a></h4>");
            }
            } catch(Exception  e) {
                out.println("<h1>Sorry something went wrong</h1>");                
                out.println("<h4><a href=\"index.jsp\">Index</a></h4>");
            }
%>

</body>
</html>

