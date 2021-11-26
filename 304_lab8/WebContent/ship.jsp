<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// Loading Driver
	try {	
		// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	} catch (java.lang.ClassNotFoundException e) {
		out.println("ClassNotFoundException: " +e);
	}

	// TODO: Get order id
	String orderIdParameter = request.getParameter("orderId");
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";
    boolean validOrderID = false;
	boolean associatedValidOrderItems = false;
	// TODO: Check if valid order id
	try (Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();
	Statement stmt1 = con.createStatement();) {
		// Checks if orderId is valid
		ResultSet rst = stmt.executeQuery("SELECT orderId FROM ordersummary");
		while(rst.next()){
			if(Integer.toString(rst.getInt("orderId")).equals(orderIdParameter)){
				validOrderID = true;
			}
		}
		// Checks if orderId is associated valid order items
		ResultSet rst1 = stmt.executeQuery("SELECT orderId FROM orderproduct");
		while(rst1.next()){
			if(Integer.toString(rst1.getInt("orderId")).equals(orderIdParameter)){
				associatedValidOrderItems = true;
			}
		}
	} catch (SQLException ex) { 	
		out.println(ex); 
	}

	if(associatedValidOrderItems && validOrderID) {
		try (Connection con1 = DriverManager.getConnection(url, uid, pw);
			 Statement stmt = con1.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			 Statement stmt1 = con1.createStatement();
			 Statement stmt2 = con1.createStatement();) {
				boolean shouldRollBack = false;
				con1.setAutoCommit(false);
				ResultSet rst = stmt1.executeQuery("SELECT * FROM orderproduct WHERE orderId = " + orderIdParameter);
				ResultSet rst1 = stmt.executeQuery("SELECT * FROM productinventory WHERE warehouseId = 1");
				while(rst.next()) {
					while(rst1.next()) {	
						if(rst.getInt("productId") == rst1.getInt("productId")) {
							if(rst1.getInt("quantity")-rst.getInt("quantity") >= 0) {
								out.println("<h1> Ordered Product: " + rst.getInt("productId") + "| Quantity " + rst.getInt("quantity") + "| Previous Inventory: " + rst1.getInt("quantity") + "| New Inventory: " + (rst1.getInt("quantity")-rst.getInt("quantity")) + "</h1>");
								PreparedStatement pstmt = con1.prepareStatement("Insert INTO shipment(shipmentDate, shipmentDesc, warehouseId) VALUES(?, ?, ?)");
								pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
								pstmt.setString(2, orderIdParameter + " Order");
								pstmt.setInt(3, 1);
								pstmt.executeUpdate();
								PreparedStatement pstmt1 = con1.prepareStatement("UPDATE productinventory SET quantity = ? WHERE warehouseId = 1 AND productId = ?");
								pstmt1.setInt(1, rst1.getInt("quantity")-rst.getInt("quantity"));
								pstmt1.setInt(2, rst.getInt("productId"));
								pstmt1.executeUpdate();
							} else {
								out.println("<h1>Shipment not done. Insufficient inventory for product id: " + rst.getInt("productId") + "</h1>");
								shouldRollBack = true;
								break;
							}

						}
					}
					rst1.beforeFirst();
				}
				if(shouldRollBack) {
					con1.rollback();
				} else {
					con1.commit();
					out.println("<h1>Shipment Successfully Processed</h1>");
				}
				
		}  catch (SQLException ex) { 	
			out.println(ex);
		} 
	} else {
		if(validOrderID == false) {
			out.println("<h1>Invalid Order ID</h1>");
		} else {
			out.println("<h1>Order does not have proper items</h1>");
		}
	}
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>