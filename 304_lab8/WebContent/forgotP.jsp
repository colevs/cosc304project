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
  String user = request.getParameter("username");
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
try ( Connection con = DriverManager.getConnection(url, uid, pw);
		    Statement stmt = con.createStatement();) 	{
			boolean flag = false;
            String sql = "SELECT userid FROM customer";
            PreparedStatement P = con.prepareStatement(sql); 
            ResultSet rst = P.executeQuery();
            
            while(rst.next()) {
                if(rst.getString("userid").equals(user)){
                    flag = true;
                }
            }
            if(flag) {
                out.println("<h1>Go to next page to update</h1>");
                out.println("<form> <input type=\"hidden\" id=\"custId\" name=\"custId\" value=\" " + user + " \"> <button type=\"submit\">Submit</button> </form>");
            } else {
                out.println("<h1>Error, the username you entered does not exist. Please register for a new account.</h1>");
                out.println("<h1>" + request.getParameter("username") + "</h1>");
                out.println("<h4><a href=\"login.jsp\">Login</a></h4>");
            }
        }  catch (Exception e) {
                out.println("<h1>Sorry, something went wrong. Try again.</h1>");
                out.println("<h4><a href=\"forgotPassword.jsp\">Forgot Password</a></h4>");
            }
%>
        
        