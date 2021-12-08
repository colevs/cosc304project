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
                if(rst.getString("userid").equals(user)){
               %> <jsp:forward page="changePassword.jsp" />
                <%}
                else {
                out.println("Error, the username you entered does not exist. Please register for a new account.");
                }
            }
        }  catch (Exception e) {
                out.println("An "+ e + " has occurred");
                %> <jsp:forward page="forgotPassword.jsp" /><%
            }
%>
        