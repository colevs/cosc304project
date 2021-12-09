<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Registration page</title>
</head>
<body>
    <form action="r.jsp" method="post">
    <h2 align="center">Register Account: </h2>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter first Name:</font></div></td>
        <td><input type="text" name="firstName"  size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter last Name:</font></div></td>
        <td><input type="text" name="lastName" size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter Email:</font></div></td>
        <td><input type="text" name="email"  size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter Phone Number:</font></div></td>
        <td><input type="text" name="phonenum" size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter Address:</font></div></td>
        <td><input type="text" name="address"  size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter City :</font></div></td>
        <td><input type="text" name="city" size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter State:</font></div></td>
        <td><input type="text" name="state"  size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter Postal Code:</font></div></td>
        <td><input type="text" name="postalCode" size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter Country:</font></div></td>
        <td><input type="text" name="country"  size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter username:</font></div></td>
        <td><input type="text" name="userid" size=10 maxlength= 30 required></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter password:</font></div></td>
        <td><input type="text" name="pword"  size=10 maxlength= 30 required></td>
    </tr>
    <input class="submit" type="submit" name="Register" value="Register">

</body>
</html>