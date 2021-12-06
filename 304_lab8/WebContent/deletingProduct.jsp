<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<%@ page import="java.math.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Deleting Product</title>
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
			Statement stmt = con.createStatement();) 	{
                String proudctID = request.getParameter("proudctID");
                String sqlInsert = "DELETE FROM product WHERE productId = ?";
                PreparedStatement pstmt = con.prepareStatement(sqlInsert);
                pstmt.setInt(1, Integer.parseInt(proudctID));
                pstmt.executeUpdate();
                out.println("<h1>The Product: " + proudctID + " Has Been Deleted</h1>");
            } catch(Exception  e) {
                out.println(e);
                out.println("<h1>Sorry something went wrong</h1>");                
                out.println("<h4><a href=\"deleteProduct.jsp\">Add Product</a></h4>");
            }
%>
</body>
</html>