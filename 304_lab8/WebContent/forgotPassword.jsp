<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Forgot Password Page</title>
</head>
<body>

    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Enter your username: </font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10 required></td>

<%
 String user = request.getParameter("username");
 String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
try ( Connection con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement();) 	{
			String sql = "SELECT userid FROM customer";
            PreparedStatement P = con.prepareStatement(sql); 
            ResultSet rst = P.executeQuery();
            while(rst.next()) {
                if(r.getString(userid).equals(uid)){
                response.sendRedirect("changePassword.jsp");
                }
                else {
                out.println("Error, the username you entered does not exist. Please register for a new account.");
                }
            }
        }  catch Exception e {
                out.println("An error has occurred");
            }

%>
</body>
</html>