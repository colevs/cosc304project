<!DOCTYPE html>
<html>
<head>
        <title>Ray's Grocery Main Page</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <style>
            th, td, a {
                padding: 5px;
            }
        </style>
</head>
<body>

<div align="right" class="topnav">
    <a href="listprod.jsp">Begin Shopping</a>
    <a href="listorder.jsp">List All Orders</a>
    <a href="customer.jsp">Customer Info</a>
    <a href="admin.jsp">Administrators</a>
<%
if(session.getAttribute("authenticatedUser") != null) {
    out.println("<b>Signed in as: " + session.getAttribute("authenticatedUser") + "</b>");
}
if(session.getAttribute("authenticatedUser") != null) {
    out.println("<a href=\"logout.jsp\">Log out</a>");
} else {
    out.println("<a href=\"login.jsp\">Log in</a>");
}
%>
</div>
        
<h1 align="center">Welcome to Ray's Grocery</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<!---<h2 align="center"><a href="accountPage.jsp">Account Info</a></h2> --->

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<!---<h2 align="center"><a href="logout.jsp">Log out</a></h2>--->

<%
// TODO: Display user name that is logged in (or nothing if not logged in)
if(session.getAttribute("authenticatedUser") != null) {
        out.print("<h2 align=\"center\">");
        out.println("<a href=\"logout.jsp\">Logout</a></h2>");
        out.println("<h2 align=\"center\"><a href=\"accountPage.jsp\">Account Page</a></h2>");
        out.println("<h3 align=\"center\">Signed in as: " + session.getAttribute("authenticatedUser") + "</h3>");

}	
%>
</body>
</head>


