<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Change Password Page</title>
</head>
<body>
    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2"> Enter your new Password:</font></div></td>
	<td><input type="password" name="password1" size=10 maxlength="10" required></td>
    
    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2"> Re-Enter your new Password:</font></div></td>
	<td><input type="password" name="password2" size=10 maxlength="10" required></td>

<%
String p1 = request.getParameter("password1");
String p2 = request.getParameter("password2");
if (p1.equals(p2)) {
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";
    String Cid = "";
    try ( Connection con = DriverManager.getConnection(url, uid, pw);
		    Statement stmt = con.createStatement();) 	{
			String sql = "SELECT customerId FROM customer";
            PreparedStatement P = con.prepareStatement(sql); 
            ResultSet rst = P.executeQuery();
            while(rst.next()) {
                Cid = rst.getString("customerId");
            }
            String SQL = "UPDATE customer SET password =? WHERE customerId = ?";
            PreparedStatement Pst = con.prepareStatement(SQL);
            Pst.setString(11,p1);
            Pst.setString(1,Cid);
            Pst.executeUpdate();

        }  catch Exception e {
                out.println("An error has occurred");
}
}

else {
out.println("The passwords do not match. Please retry entering them.")

}


%>

</body>
</html>