<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.math.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Bigtime Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";
	String customerFirstName = "";
	String customerLastName = "";
	int intCustId = Integer.parseInt(custId);
	int orderId = 0;
	boolean flag = false;
	try ( Connection con = DriverManager.getConnection(url, uid, pw);
		  Statement stmt = con.createStatement();) 	{	
		ResultSet rst = stmt.executeQuery("SELECT customerid, firstName, lastName FROM customer");
		while(rst.next()){
			if(Integer.toString(rst.getInt("customerId")).equals(custId)){
				customerFirstName = rst.getString("firstName");
				customerLastName = rst.getString("lastName");
				flag=true;
			}
		}
	}	catch (SQLException ex) {     
		out.println(ex); 
	}

	if(flag) {
		if(productList == null) {
			out.println("<h1>No Items</h1>");
		} else {
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			double totalPrice = 0;
			out.println("<h1>Your Order Summary</h1>");
			out.println("<table>");
			out.println("<tr>");
			out.println("<th>Product ID</th>");
			out.println("<th>Product Name</th>");
			out.println("<th>Quantity</th>");
			out.println("<th>Price</th>");
			out.println("<th>Subtotal</th>");		
			out.println("</tr>");
			try ( Connection con = DriverManager.getConnection(url, uid, pw);
			Statement stmt = con.createStatement();) 	{	
		 		String sqlInsertStatement = "INSERT INTO ordersummary (orderDate, customerId) VALUES (?, ?)";
				PreparedStatement pstmt = con.prepareStatement(sqlInsertStatement,  Statement.RETURN_GENERATED_KEYS);
				pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis())); 					  
				pstmt.setInt(2, intCustId);
				pstmt.execute();
				ResultSet keys = pstmt.getGeneratedKeys();
				keys.next();
				orderId = keys.getInt(1);
			}	catch (SQLException ex) {
					out.println(ex); 
			}
			while (iterator.hasNext()) {
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String productId = (String) product.get(0);
				String name = (String) product.get(1);	
				String stringPrice = (String) product.get(2);			
				double pr = Double.parseDouble(stringPrice);
				int qty = ( (Integer)product.get(3)).intValue();
				double subTotal = (qty*pr);
				totalPrice = totalPrice + (qty*pr);
				out.println("<tr>");
					out.println("<td>" + productId + "</td>");
					out.println("<td>" + name + "</td>");
					out.println("<td>" + qty + "</td>");
					out.println("<td>" + currFormat.format(pr) + "</td>");
					out.println("<td>" + currFormat.format(subTotal) + "</td>");
				out.println("</tr>");
				try ( Connection con = DriverManager.getConnection(url, uid, pw);
		  			  Statement stmt = con.createStatement();) 	{
					  String sqlInsertStatementOrderProduct = "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
					  PreparedStatement pstmt1 = con.prepareStatement(sqlInsertStatementOrderProduct);
					  pstmt1.setInt(1, orderId);
					  pstmt1.setInt(2, Integer.parseInt(productId));
					  pstmt1.setInt(3, qty);
					  pstmt1.setBigDecimal(4, BigDecimal.valueOf(subTotal));
					  pstmt1.executeUpdate();
					}	catch (SQLException ex) {
							out.println(ex); 
					}
			}
			out.println("<tr align='right'>");
			out.println("<td colspan='5'>");
			out.println("<table>");
			out.println("<th>Order Total:" + currFormat.format(totalPrice) + "</th>");
			try ( Connection con = DriverManager.getConnection(url, uid, pw);
			Statement stmt = con.createStatement();) 	{	
			PreparedStatement pstmt2 = con.prepareStatement("UPDATE ordersummary SET totalAmount = ? WHERE orderId = ?");
			pstmt2.setBigDecimal(1, BigDecimal.valueOf(totalPrice));
			pstmt2.setInt(2, orderId);
			pstmt2.executeUpdate();			
	  		}	catch (SQLException ex) {
				out.println(ex); 
			  }
			out.println("</td>");
			out.println("</table>");
			out.println("</td>");
			out.println("</tr>");
			out.println("</table>");
			out.println("<h1>Order completed. Will be shipped soon...</h1> <br>");
			out.println("<h1>Your order reference number is: " + orderId + "</h1> <br>");
			out.println("<h1> Shipping to customer: " + custId + " Name: " + customerFirstName + " " + customerLastName + "</h1>");
			productList.clear();
			productList = null;
			session.setAttribute("productList", productList);
		}
	} else {
		out.println("<h1>Invalid customer id. Go back to the previous page and try again.</h1>");
	}
// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
// If either are not true, display an error message

// Make connection

// Save order information to database


	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
%>
</BODY>
</HTML>
