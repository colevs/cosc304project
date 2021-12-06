<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<%@ page import="java.math.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Updating Product</title>
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
                String productName = request.getParameter("productName");
                String productPrice = request.getParameter("productPrice");
                String categoryID = request.getParameter("categoryID");
                String productDesc = request.getParameter("productDesc");
                double price = Double.parseDouble(productPrice);
                
                String sqlUpdate = "UPDATE product SET productName = ?, productPrice = ?, productDesc = ?, categoryId = ? WHERE productId = ? ";
                PreparedStatement pstmt = con.prepareStatement(sqlUpdate);
                
                pstmt.setString(1, productName);
                pstmt.setBigDecimal(2, BigDecimal.valueOf(price));
                pstmt.setString(3, productDesc);
                pstmt.setInt(4, Integer.parseInt(categoryID));
                pstmt.setInt(5, Integer.parseInt(proudctID));
                pstmt.executeUpdate();
                out.println("<h1>The Product: " + productName + " with ID: " + proudctID + " Has Been Updated</h1>");
            } catch(Exception  e) {
                out.println(e);
                out.println("<h1>Sorry something went wrong</h1>");                
                out.println("<h4><a href=\"updateProduct.jsp\">Update Product</a></h4>");
            }
%>
</body>

</html>