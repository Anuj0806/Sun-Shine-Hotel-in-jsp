<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>
<%@include file="config.jsp" %>
    <%
           if (session.getAttribute("email") == null) {
                response.sendRedirect("guest_login_signup_page.html#cover");
            }
            String guest_Id_details = String.valueOf(session.getAttribute("guest_id"));
             String guest_EmailId_details = String.valueOf(session.getAttribute("email"));
            ArrayList arr = new ArrayList();
            Connection conn = null;
            try {
                Class.forName(driver);
                conn = DriverManager.getConnection(url, user, password1);    
                String sql = "SELECT r.room_no FROM booking_details b JOIN all_room r ON b.room_no = r.room_id  WHERE b.email = ? AND b.approve_status = 'A' AND b.reservation_status = 'R' order by r.room_no";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, guest_EmailId_details);;
                ResultSet roomRs = pst.executeQuery();
                while (roomRs.next()) {
                    arr.add(roomRs.getString("room_no"));
                }
                
                sql = "SELECT r.room_no FROM booking_details b JOIN all_room r ON b.room_no = r.room_id  WHERE b.email = ? AND b.approve_status = 'A' AND b.reservation_status = 'R' order by r.room_no";
                pst = conn.prepareStatement(sql);
                pst.setString(1, guest_Id_details);;
                roomRs = pst.executeQuery();
                while (roomRs.next()) {
                    arr.add(roomRs.getString("room_no"));
                }
                roomRs.close();
                pst.close();

            } catch (Exception e) {
                out.print(e);
            }
            if(!arr.isEmpty()){
        %>
<html>
    <head>
        <title>Food Menu</title>
        <link rel="icon" href="./image/hotel-sign.png">
        <link href="./css/tables.css" rel="stylesheet">
        <link rel="stylesheet" href="./css/alert.css">
        <style>
            .overlay {
                position: fixed;
                top: 0;
                bottom: 0;
                left: 0;
                right: 0;
                background: rgba(0, 0, 0, 0.7);
                transition: opacity 500ms;
                visibility: hidden;
                opacity: 1;
            }
            .overlay:target {
                visibility: visible;
                opacity: 1;
            }

            .popup {
                margin: 70px auto;
                padding: 20px;
                background: #fff;
                border-radius: 5px;
                width: 30%;
                position: relative;
                transition: all 5s ease-in-out;
            }

            .popup h2 {
                margin-top: 0;
                color: #333;
                font-family: Tahoma, Arial, sans-serif;
            }
            .popup .close {
                position: absolute;
                top: 20px;
                right: 30px;
                transition: all 200ms;
                font-size: 30px;
                font-weight: bold;
                text-decoration: none;
                color: #333;
            }
            .popup .close:hover {
                color: #06D85F;
            }
            .popup .content {
                max-height: 30%;
                overflow: auto;
            }

            @media screen and (max-width: 700px){
                .box{
                    width: 70%;
                }
                .popup{
                    width: 70%;
                }
            }
        </style>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const rows = document.querySelectorAll('tr.item-row');
                const checkboxes = document.querySelectorAll('input[type="checkbox"]');
                const quantities = document.querySelectorAll('input[type="number"]');
                const priceElements = document.querySelectorAll('.price');
                const totalPriceElement = document.getElementById('total-price');

                rows.forEach((row, index) => {
                    row.addEventListener('click', () => {
                        checkboxes[index].checked = !checkboxes[index].checked;
                        quantities[index].disabled = !checkboxes[index].checked;
                        updateTotalPrice();
                    });
                });

                checkboxes.forEach((checkbox, index) => {
                    checkbox.addEventListener('change', () => {
                        quantities[index].disabled = !checkbox.checked;
                        updateTotalPrice();
                    });
                });

                quantities.forEach((quantity, index) => {
                    quantity.addEventListener('click', (event) => {
                        event.stopPropagation();
                    });

                    quantity.addEventListener('input', updateTotalPrice);
                });

                function updateTotalPrice() {
                    let totalPrice = 0;
                    checkboxes.forEach((checkbox, index) => {
                        if (checkbox.checked) {
                            const quantity = quantities[index].value;
                            const price = parseFloat(priceElements[index].dataset.price);
                            totalPrice += quantity * price;
                        }
                    });
                    totalPriceElement.textContent = totalPrice.toFixed(2);
                    document.getElementById("totalPriced").value = totalPrice.toFixed(2);
                }

                // Function to show room selection if more than one room
                function showRoomSelection() {

                    document.getElementById("room-selection").style.display = 'block';
                    orderForm.onsubmit = function () {
                        if (roomSelect.value === "") {
                            alert("Please select a room.");
                            return false; // Prevent form submission if room is not selected
                        }
                    };
                }

                // Check number of rooms and show room selection if more than one
                const roomCount = <%= arr.size()%>;
                if (roomCount > 1) {
                  document.getElementById("popup1").style.visibility="visible";
                    showRoomSelection();
                }else{
                     document.getElementById("room_id").value =  <%= arr.get(0)%>;
                }
                
                
            });
            
         function  closepopup(){
             var room =document.getElementById("room_id").value;             
                if(room===""){
                    alert('Please Select the Room');
                }else{
                      document.getElementById("popup1").style.visibility="hidden";
                      document.getElementById("popup1").style.opacity="0";
                      document.getElementById("room_id").value =  room;
                 }
            }
        </script>
    </head>
    <body>

        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>
                <li class="items"><a>Food Menu</a></li>
                <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
            </ul>
        </nav>
        <div>
            <form id="orderForm" action="" method="post" class="search-container">
                <div class="container" style="height: 90%;top: 16%">
                    <table>
                        <tr>
                            <th>Select</th>
                            <th>Item</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>Quantity</th>
                        </tr>
                        <%

                            Statement stmt = null;
                            ResultSet rs = null;
                            try {
                                Class.forName(driver);
                                conn = DriverManager.getConnection(url, user, password1);
                                stmt = conn.createStatement();
                                String sql = "SELECT * FROM menu";
                                rs = stmt.executeQuery(sql);
                                while (rs.next()) {
                        %>
                        <tr class="item-row">
                            <td><input type="checkbox" name="item_id" value="<%= rs.getInt("item_id")%>"></td>
                            <td><%= rs.getString("item_name")%></td>
                            <td><%= rs.getString("description")%></td>
                            <td class="price" data-price="<%= rs.getDouble("price")%>">$<%= rs.getDouble("price")%></td>
                            <td><input type="number" name="quantity" value="1" min="1" disabled></td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                try {
                                    if (rs != null) {
                                        rs.close();
                                    }
                                    if (stmt != null) {
                                        stmt.close();
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        %>
                    </table>
                </div>
                <div style="position: relative;width: 100%;top: 20px;left: 38px;">
                    <div class="total-price-container" style="text-align: center;">
                        <strong>Total Price: $<span id="total-price">0.00</span></strong>
                    </div>
                    <input type="hidden" name="totalPriced" id="totalPriced">
                    <input type="hidden" name="guest_id" value="<%= session.getAttribute("guest_id")%>">

                    <div id="popup1" class="overlay">
                        <div class="popup">
                            <h2>Select the Room</h2>
                            <a class="close" onclick="closepopup()" href="#">&times;</a>
                            <div class="content">
                                <label for="room_id">Select Room:</label>
                                <select onchange="closepopup()" name="room_id" id="room_id">
                                    <option value=""  selected>Select your option</option>
                                    <% for (int i = 0; i < arr.size(); i++) {%>
                                    <option><%=arr.get(i)%></option>
                                    <% }%>
                                </select>
                            </div>
                        </div>
                    </div>
                    

                    <input type="submit" onsubmit="showRoomSelection()" style="width: 15%;" value="Order">
                </div>
            </form>
        </div>

        <%
            if ("post".equalsIgnoreCase(request.getMethod())) {
                PreparedStatement pstmtOrder = null;
                PreparedStatement pstmtOrderItem = null;
                ResultSet generatedKeys = null;

                try {
                    Class.forName(driver);
                    conn = DriverManager.getConnection(url, user, password1);
                    conn.setAutoCommit(false);

                    String[] itemIds = request.getParameterValues("item_id");
                    String[] quantities = request.getParameterValues("quantity");
                    String guestId = request.getParameter("guest_id");
                    String totalPriced = request.getParameter("totalPriced");
                    String roomId = request.getParameter("room_id");

                    double totalPrice = Double.parseDouble(totalPriced);

                    String insertOrderSql = "INSERT INTO orders (guest_id, room_id, total_price) VALUES (?, ?, ?)";
                    pstmtOrder = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS);
                    pstmtOrder.setInt(1, Integer.parseInt(guestId));
                    pstmtOrder.setInt(2, Integer.parseInt(roomId));
                    pstmtOrder.setDouble(3, totalPrice);
                    pstmtOrder.executeUpdate();

                    generatedKeys = pstmtOrder.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int orderId = generatedKeys.getInt(1);

                        String insertOrderItemSql = "INSERT INTO order_items (order_id, item_id, quantity) VALUES (?, ?, ?)";
                        pstmtOrderItem = conn.prepareStatement(insertOrderItemSql);

                        for (int i = 0; i < itemIds.length; i++) {
                            int itemId = Integer.parseInt(itemIds[i]);
                            int quantity = Integer.parseInt(quantities[i]);
                            pstmtOrderItem.setInt(1, orderId);
                            pstmtOrderItem.setInt(2, itemId);
                            pstmtOrderItem.setInt(3, quantity);
                            pstmtOrderItem.addBatch();
                        }
                        pstmtOrderItem.executeBatch();
                        conn.commit();
        %>
        <script>
            alert("The order was successfully placed! You can change/cancel your order within 5 minutes of booking.");
            window.location = "guestloginpage.jsp";
        </script>
        <%
            } else {
                throw new SQLException("Failed to retrieve the order ID.");
            }
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        %>
        <script>
            alert("An error occurred while processing your request.");
            window.location = "guestloginpage.jsp";
        </script>
        <%
                    e.printStackTrace();
                } finally {
                    try {
                        if (generatedKeys != null) {
                            generatedKeys.close();
                        }
                        if (pstmtOrderItem != null) {
                            pstmtOrderItem.close();
                        }
                        if (pstmtOrder != null) {
                            pstmtOrder.close();
                        }
                        if (conn != null) {
                            conn.close();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
}else{
%>
<script>
    alert("No room is booked by the user.");
    window.location="guestloginpage.jsp";
</script>
        <%
}

        %>
    </body>
</html>
