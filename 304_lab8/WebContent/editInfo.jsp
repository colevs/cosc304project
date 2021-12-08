<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Edit Information</title>
</head>
<body>
    <% 
    String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";
    try ( Connection conn = DriverManager.getConnection(url, uid, pw);
    Statement stmt = conn.createStatement();) {

    String SQL = "SELECT * FROM customer";
    PreparedStatement PT = conn.prepareStatement(SQL);
    ResultSet r = PT.executeQuery;
    String userName = (String) session.getAttribute("authenticatedUser");
    while(r.next()){
    if(userName.equals(r.getString("userid"))) {
        String Cid = r.getString(1);
    } 
    }
    }   catch (Exception e) {
         out.println("An" + e + " has occured. Please enter a valid statment.")       }
    %>
    <h2 align="center">Edit Personal Information: </h2>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit first Name:</font></div></td>
        <td><input type="text" name="firstName"  size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit last Name:</font></div></td>
        <td><input type="text" name="lastName" size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit Email:</font></div></td>
        <td><input type="text" name="email"  size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit Phone Number:</font></div></td>
        <td><input type="text" name="phonenum" size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit Address:</font></div></td>
        <td><input type="text" name="address"  size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit City :</font></div></td>
        <td><input type="text" name="city" size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit State:</font></div></td>
        <td><input type="text" name="state"  size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit Postal Code:</font></div></td>
        <td><input type="text" name="postalCode" size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit Country:</font></div></td>
        <td><input type="text" name="country"  size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit username:</font></div></td>
        <td><input type="text" name="userid" size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit password:</font></div></td>
        <td><input type="text" name="pword"  size=10 maxlength= 30></td>
    </tr>
    <input class="submit" type="submit" name="Enter" value="Enter">
    <% 
            String Firstname = request.getParameter("firstName");
            String Lastname = request.getParameter("lastName");
            String Email = request.getParameter("email");
            String Phonenumber = request.getParameter("phonenum");
            String Address = request.getParameter("address")
            String City = request.getParameter("city");
            String State = request.getParameter("state");
            String Postalcode = request.getParameter("postalCode");
            String Country = request.getParameter("country");
            String User = request.getParameter("userid");
            String Password = request.getParameter("pword");
            
            String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
            String uid = "SA";
            String pw = "YourStrong@Passw0rd";
            try ( Connection con = DriverManager.getConnection(url, uid, pw);
            Statement stmt = con.createStatement();) {
            Statement stmt = con.createStatement();) 	{
			String sql = "UPDATE customer SET firstName = ?, lastName = ?, email = ?, phonenum = ?," 
            + "address = ?, city = ?, state = ?, postalCode = ?, country = ?, userid = ?, password = ?" 
            +"WHERE customerId = ?";
			PreparedStatement P = con.prepareStatement(sql); 
            P.setString(1,Cid);
            P.setString(2,Firstname);
            P.setString(3,Lastname);
            P.setString(4,Email);
            P.setString(5,Phonenumber);
            P.setString(6,Address);
            P.setString(7,City);
            P.setString(8,State);
            P.setString(9,Postalcode);
            P.setString(10,Country);
            P.setString(11,User);
            P.setString(12,Password);
            
            P.executeUpdate();
            } catch (Exception e) {
            out.println("An" + e + " has occured. Please enter a valid statment."); 
            }
    %>
</body>
</html>