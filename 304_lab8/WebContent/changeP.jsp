<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<%@ page import="java.math.*" %>
<% 
try {
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
  } catch (java.lang.ClassNotFoundException e) {
    out.println("ClassNotFoundException: " + e);
  }
String p1 = request.getParameter("password1");
String p2 = request.getParameter("password2");
    if (p1.equals(p2)) {
    String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";

        Cid = rst.getString("customerId");
        try ( Connection con = DriverManager.getConnection(url, uid, pw);
		    Statement stmt = con.createStatement();) 	{
			String sql = "SELECT customerId FROM customer";
            PreparedStatement P = con.prepareStatement(sql); 
            ResultSet rst = P.executeQuery();
            while(rst.next()) {
                Cid = rst.getString("customerId");
            }
            
            String SQL = "UPDATE customer SET password = ? WHERE customerId = ?";
            PreparedStatement Pst = con.prepareStatement(SQL);
            Pst.setString(1,p1);
            Pst.setString(2,Cid);
            Pst.executeUpdate();
            out.println("<h1>Done!</h1>");
            out.println("<h4><a href=\"login.jsp\">Login</a></h4>");
        }  catch (Exception e) {
                out.println("<h1>An error has occurred</h1>");
                out.println("<h4><a href=\"changePassword.jsp\">Try Again</a></h4>");
        }
}
%>