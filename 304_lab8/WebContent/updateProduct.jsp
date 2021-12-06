<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<%@ page import="java.math.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Update Product</title>
</head>
<body>
    <h1>Which Product Would You Like To Update:</h1>
    <form action="updatingProduct.jsp" method="GET">
        <div>
            <label for="proudctID">Product ID: </label>
            <input type="number" name="proudctID" required min="1">
        </div>
        <h1>What Information Would You Like to Update:</h1>
        <div>
            <label for="proudctName">Product Name: </label>
            <input type="text" name="productName" required>
        </div>
        <div>
            <label for="productPrice">Product Price: </label>
            <input type="text" name="productPrice" required>            
        </div>
        <div>
            <label for="categoryID">Category ID: </label>
            <input type="number" name="categoryID" required min="1">                
        </div>
        <div>
            <label for="productDesc">Product Description: </label>
            <textarea name="productDesc" maxlength="1000"></textarea>
        </div>  
        <button type="submit">Submit</button>
        <button type="reset">Reset</button>
    </form>
    <%
    try {
	    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    } catch (java.lang.ClassNotFoundException e) {
	    out.println("ClassNotFoundException: " + e);
    }

    String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";
    NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
    try ( Connection con = DriverManager.getConnection(url, uid, pw);
			Statement stmt = con.createStatement();) 	{
                String sqlInsert = "SELECT * FROM product";
                PreparedStatement pstmt = con.prepareStatement(sqlInsert);
                ResultSet rst2 = pstmt.executeQuery();
                out.println("<table class=\"table\" border=\"1\">");
                    out.println("<tr>");
                        out.println("<th>Product ID</th>");
                        out.println("<th>Name</th>");
                        out.println("<th>Price</th>");
                    out.println("</tr>");
                while(rst2.next()) {
                    out.println("<tr>");
                        out.println("<th>" + rst2.getInt(1) + "</th>");
                        out.println("<th>" + rst2.getString(2) + "</th>");
                        out.println("<th>" + currFormat.format(rst2.getBigDecimal("productPrice")) + "</th>");
                    out.println("</tr>");
                }
                out.println("</table>");
            } catch(Exception  e) {
                out.println(e);
            }
%>
</body>
</html>