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
String Firstname = request.getParameter("firstName");
String Lastname = request.getParameter("lastName");
String Email = request.getParameter("email");
String Phonenumber = request.getParameter("phonenum");
String Address = request.getParameter("address");
String City = request.getParameter("city");
String State = request.getParameter("state");
String Postalcode = request.getParameter("postalCode");
String Country = request.getParameter("country");
String User = request.getParameter("userid");
String Password = request.getParameter("pword");

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
try ( Connection conn = DriverManager.getConnection(url, uid, pw);
Statement stmt = conn.createStatement();) {

String SQL = "SELECT * FROM customer";
PreparedStatement PT = conn.prepareStatement(SQL);
ResultSet r = PT.executeQuery();
String userName = (String) session.getAttribute("authenticatedUser");
while(r.next()){
if(userName.equals(r.getString("userid"))) {
int Cid = r.getInt(1);

String sql = "UPDATE customer SET firstName = ?, lastName = ?, email = ?, phonenum = ?, address = ?, city = ?, state = ?, postalCode = ?, country = ?, userid = ?, password = ? WHERE customerId = ?";

PreparedStatement P = conn.prepareStatement(sql); 
P.setString(1,Firstname);
P.setString(2,Lastname);
P.setString(3,Email);
P.setString(4,Phonenumber);
P.setString(5,Address);
P.setString(6,City);
P.setString(7,State);
P.setString(8,Postalcode);
P.setString(9,Country);
P.setString(10,User);
P.setString(11,Password);
P.setInt(12, Cid);
P.executeUpdate();
out.println("<h1>Account Added</h1>");                
out.println("<h4><a href=\"login.jsp\">Login</a></h4>");
}
}
}
catch (Exception e) { 
out.println("<h1>Sorry something went wrong</h1>");                
out.println("<h4><a href=\"editInfo.jsp\">Register</a></h4>");
}

%>