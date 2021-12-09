<%
String p1 = request.getParameter("password1");
String p2 = request.getParameter("password2");
    if (p1.equals(p2)) {
    String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
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
            %>
                <jsp:forward page="login.jsp" />
            <%
        }  catch (Exception e) {
                out.println("An error has occurred");
                %>
                <jsp:forward page="changePassword.jsp" />
                <%
            }
}
    else {
    out.println("The passwords do not match. Please retry entering them.");
%>
<jsp:forward page="changePassword.jsp" />
<%}

%>
