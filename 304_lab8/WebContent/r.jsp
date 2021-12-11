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
    String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";
    try ( Connection con = DriverManager.getConnection(url, uid, pw);
    Statement stmt = con.createStatement();) {
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
            
            String SQL = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ? ,?, ?, ?)";
            PreparedStatement Pt = con.prepareStatement(SQL);
            Pt.setString(1,Firstname);
            Pt.setString(2,Lastname);
            Pt.setString(3,Email);
            Pt.setString(4,Phonenumber);
            Pt.setString(5,Address);
            Pt.setString(6,City);
            Pt.setString(7,State);
            Pt.setString(8,Postalcode);
            Pt.setString(9,Country);
            Pt.setString(10,User);
            Pt.setString(11,Password);
            Pt.executeUpdate();
            out.println("<h1>Account Added</h1>");                
            out.println("<h4><a href=\"login.jsp\">Login</a></h4>");
       }
    catch (Exception e) { 
      out.println("<h1>Sorry something went wrong</h1>");                
      out.println("<h4><a href=\"register.jsp\">Register</a></h4>");
    }
%>