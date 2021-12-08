<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Forgot Password Page</title>
</head>
<body>
    <form action="forgotP.jsp" method="post"></form>
    <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter your username: </font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10 required></td>
    <input class="submit" type="submit" name="entered" value="Enter">

</body>
</html>