<%@page import="java.sql.SQLException"%>
<%@include file="config.jsp" %>
<html>
<head>
    <title>Chef Page - Order Details</title>
    <link rel="icon" href="./image/hotel-sign.png">
    <link href="./css/tables.css" rel="stylesheet">
    <link rel="stylesheet" href="./css/alert.css">
    <!-- Add FontAwesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <!-- Add JavaScript for AJAX request -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
    <%
        if (session.getAttribute("employee") == null && session.getAttribute("admin_email") == null) {
                response.sendRedirect("employeelogin.html");
            }
    %>
<body>
    <nav>
        <ul>
            <li class="logo">Sun Shine Hotel</li>
            <li class="items"><a>Order Details</a></li>
            <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
        </ul>
    </nav>
    <div class="container" >
        <table>
            <tr style="position: sticky; z-index: 5;">
                <th>Order ID</th>
                <th>Guest ID</th>
                <th>Order Date</th>
                <th>Status</th>
                <th>Total Price</th>
                <th>Items</th>
                <th>Action</th> <!-- Add a new column for action -->
            </tr>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                PreparedStatement itemsPstmt = null;
                ResultSet rsItems = null;

                try {
                    Class.forName(driver);
                    conn = DriverManager.getConnection(url,user, password1);
                   String sql = "SELECT o.order_id, o.guest_id, o.order_date, o.status, o.total_price, g.name " +
                     "FROM orders o " +
                     "JOIN guest g ON o.guest_id = g.guest_id " +
                     "WHERE o.status not LIKE ? and  TIMESTAMPDIFF(MINUTE,order_date,NOW()) > 5";
                 pstmt = conn.prepareStatement(sql);
                   pstmt.setString(1, "%confirm%");
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int orderId = rs.getInt("order_id");
                        %>
                        <tr>
                            <td><%= orderId %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("order_date") %></td>
                            <td><%= rs.getString("status") %></td>
                            <td>$<%= rs.getDouble("total_price") %></td>
                            <td>
                                <table>
                                    <tr>
                                        <th>Item ID</th>
                                        <th>Item Name</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                    </tr>
                                    <%
                                        String itemsSql = "SELECT oi.item_id, m.item_name, oi.quantity, (oi.quantity * m.price) AS price FROM order_items oi JOIN menu m ON oi.item_id = m.item_id WHERE oi.order_id = ?";
                                        itemsPstmt = conn.prepareStatement(itemsSql);
                                        itemsPstmt.setInt(1, orderId);
                                        rsItems = itemsPstmt.executeQuery();
                                        while (rsItems.next()) {
                                    %>
                                    <tr>
                                        <td><%= rsItems.getInt("item_id") %></td>
                                        <td><%= rsItems.getString("item_name") %></td>
                                        <td><%= rsItems.getInt("quantity") %></td>
                                        <td>$<%= rsItems.getDouble("price") %></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </table>
                            </td>
                            <td>
                                <!-- Add a button to change status to "Confirmed" -->
                                <a  target="_blank" href="confirmOrder.jsp?orderId=<%= encryptData(String.valueOf(orderId), secretKey)%>"> <button style="padding: 0px" class="button-70" role="button"><img height="40" width="50" src="./image/food_book.png" /></button></a>
                                <!--<button onclick="confirmOrder;">Confirm</button>-->
                            </td>
                        </tr>
                        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } 
            %>
        </table>
    </div>
    <!-- Add JavaScript function to send AJAX request for status change -->
    <script>
    function confirmOrder(orderId) {           
        $.ajax({
            type: "POST",
            url: "confirmOrder.jsp",
            data: { orderId: orderId },
            success: function(response) {
                console.log(response);
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
    }
</script>

</body>
</html>
