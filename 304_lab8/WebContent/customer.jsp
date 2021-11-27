<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>
<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>


<%

// TODO: Print Customer information
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
try ( Connection con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement();) 	{
			String sql = "SELECT * FROM customer WHERE userid = ?";
			PreparedStatement P = con.prepareStatement(sql); 
			P.setString(1, userName);
			ResultSet rst = P.executeQuery();
			out.println("<h1>Customer Profile</h1>");
			out.println("<table class=\"table\" border=\"1\">");
			while(rst.next()) {
				out.println("<tr><th>Id</th>" + "<td>" + rst.getInt(1) + "</td></tr>");
				out.println("<tr><th>First Name</th>" + "<td>" + rst.getString(2) + "</td></tr>");
				out.println("<tr><th>Last Name</th>" + "<td>" + rst.getString(3) + "</td></tr>");
				out.println("<tr><th>Email</th>" + "<td>" + rst.getString(4) + "</td></tr>");
				out.println("<tr><th>Phone</th>" + "<td>" + rst.getString(5) + "</td></tr>");
				out.println("<tr><th>Address</th>" + "<td>" + rst.getString(6) + "</td></tr>");
				out.println("<tr><th>City</th>" + "<td>" + rst.getString(7) + "</td></tr>");
				out.println("<tr><th>State</th>" + "<td>" + rst.getString(8) + "</td></tr>");
				out.println("<tr><th>Postal Code</th>" + "<td>" + rst.getString(9) + "</td></tr>");
				out.println("<tr><th>Country</th>" + "<td>" + rst.getString(10) + "</td></tr>");
				out.println("<tr><th>User ID</th>" + "<td>" + rst.getString(11) + "</td></tr>");
			}
		} catch (SQLException ex) { 	
			//out.println(ex); 
		} 
// Make sure to close connection
%>

</body>
</html>

