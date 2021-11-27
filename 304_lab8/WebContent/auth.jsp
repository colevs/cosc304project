<%
	boolean authenticated = true;
	
	if (authenticated)
	{
		response.sendRedirect("admin.jsp");
	} else {
		String loginMessage = "You have not been authorized to access the URL "+request.getRequestURL().toString();
        session.setAttribute("loginMessage",loginMessage);        
		response.sendRedirect("login.jsp");
	}
%>
