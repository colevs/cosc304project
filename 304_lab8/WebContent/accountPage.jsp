<!DOCTYPE html>
<html>
<head>
<title>Account Page</title>
</head>
<body>
    <% 
    out.println("<h3 align=\"center\">" + session.getAttribute("authenticatedUser")+" profile Page: " + + "</h3>");
    %>
    <h2 align="center"><a href="customer.jsp">Account Details</a></h2>
    <h2 align="center"><a href="editInfo.jsp">Update Account</a></h2>
    <h2 align="center"><a href="logout.jsp">Logout</a></h2>

</body>
</html>