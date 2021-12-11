<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Edit Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <h2 align="center">Edit Personal Information: </h2>
    <form action="editI.jsp" method="post">
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Edit first Name:</font></div></td>
        <td><input type="text" name="firstName"  size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Edit last Name:</font></div></td>
        <td><input type="text" name="lastName" size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Edit Email:</font></div></td>
        <td><input type="text" name="email"  size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Edit Phone Number:</font></div></td>
        <td><input type="text" name="phonenum" size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Edit Address:</font></div></td>
        <td><input type="text" name="address"  size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Edit City :</font></div></td>
        <td><input type="text" name="city" size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Edit State:</font></div></td>
        <td><input type="text" name="state"  size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Edit Postal Code:</font></div></td>
        <td><input type="text" name="postalCode" size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Edit Country:</font></div></td>
        <td><input type="text" name="country"  size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Edit username:</font></div></td>
        <td><input type="text" name="userid" size=10 maxlength= 30></td>
    </tr>
    <tr>
        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Edit password:</font></div></td>
        <td><input type="text" name="pword"  size=10 maxlength= 30></td>
    </tr>
    <button type="submit">Submit</button>
    <button type="reset">Reset</button>
    </form>
</body>
</html>