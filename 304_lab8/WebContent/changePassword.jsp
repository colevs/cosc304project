<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Change Password Page</title>
</head>
<body>
    <form action="changeP.jsp" method="GET">
    <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2"> Enter your new Password:</font></div></td>
	<td><input type="password" name="password1" size=10 maxlength="10" required></td>
    
    <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2"> Re-Enter your new Password:</font></div></td>
	<td><input type="password" name="password2" size=10 maxlength="10" required></td>

    <input class="submit" type="submit" name="Submit2" value="submit">
</form>
</body>
</html>