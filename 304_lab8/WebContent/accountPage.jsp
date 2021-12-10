<!DOCTYPE html>
<html>
<head>
<title>Account Page</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <% 
    out.println("<h3 align=\"center\">" + " Profile Page: " + session.getAttribute("authenticatedUser") + "</h3>");
    %>
    <h2 align="center"><a href="customer.jsp">Account Details</a></h2>
    <h2 align="center"><a href="editInfo.jsp">Update Account</a></h2>
    <h2 align="center"><a href="logout.jsp">Logout</a></h2>

</body>
</html>