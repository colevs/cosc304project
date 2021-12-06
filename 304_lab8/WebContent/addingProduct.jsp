<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<%@ page import="java.math.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Adding Product</title>
</head>
<body>
    <%@ include file="auth.jsp" %>
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
                String productName = request.getParameter("productName");
                String productPrice = request.getParameter("productPrice");
                String categoryID = request.getParameter("categoryID");
                String productDesc = request.getParameter("productDesc");
                double price = Double.parseDouble(productPrice);
                String sqlInsert = "INSERT INTO product (productName, productPrice, productDesc, categoryId) VALUES (?, ?, ?, ?); ";
                PreparedStatement pstmt = con.prepareStatement(sqlInsert, Statement.RETURN_GENERATED_KEYS);
                pstmt.setString(1, productName);
                pstmt.setBigDecimal(2, BigDecimal.valueOf(price));
                pstmt.setString(3, productDesc);
                pstmt.setInt(4, Integer.parseInt(categoryID));
                pstmt.executeUpdate();
                ResultSet keys = pstmt.getGeneratedKeys();
				keys.next();
				int orderId = keys.getInt(1);
                out.println("<h1>The Product: " + productName + " with ID: " + orderId + " Has Been Uploaded</h1>");
            } catch(Exception  e) {
                out.println("<h1>Sorry something went wrong</h1>");                
                out.println("<h4><a href=\"addProduct.jsp\">Add Product</a></h4>");
            }
%>
</body>

</html>