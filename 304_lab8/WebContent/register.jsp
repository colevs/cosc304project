<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Registration page</title>
</head>
<body>

    <h2 align="center">Register Account: </h2>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit first Name:</font></div></td>
        <td><input type="text" name="firstName"  size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit last Name:</font></div></td>
        <td><input type="text" name="lastName" size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit Email:</font></div></td>
        <td><input type="text" name="email"  size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit Phone Number:</font></div></td>
        <td><input type="text" name="phonenum" size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit Address:</font></div></td>
        <td><input type="text" name="address"  size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit City :</font></div></td>
        <td><input type="text" name="city" size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit State:</font></div></td>
        <td><input type="text" name="state"  size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit Postal Code:</font></div></td>
        <td><input type="text" name="postalCode" size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit Country:</font></div></td>
        <td><input type="text" name="country"  size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit username:</font></div></td>
        <td><input type="text" name="userid" size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Edit password:</font></div></td>
        <td><input type="text" name="pword"  size=10 maxlength= 30 required></td>
    </tr>
    <input class="submit" type="submit" name="Enter" value="Enter">
<% 
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";
    try ( Connection con = DriverManager.getConnection(url, uid, pw);
    Statement stmt = con.createStatement();) {
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
   
            String SQL = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ? ,?, ?, ?)";
            PreparedStatement Pt = con.prepareStatement(SQL);
            Pt.setString(2,Firstname);
            Pt.setString(3,Lastname);
            Pt.setString(4,Email);
            Pt.setString(5,Phonenumber);
            Pt.setString(6,Address);
            Pt.setString(7,City);
            Pt.setString(8,State);
            Pt.setString(9,Postalcode);
            Pt.setString(10,Country);
            Pt.setString(11,User);
            Pt.setString(12,Password);
            Pt.executeUpdate();
            response.sendRedirect("login.jsp"); }
    catch (Exception e) { out.println("An" + e +" has occurred.")}
%>
</body>
</html>