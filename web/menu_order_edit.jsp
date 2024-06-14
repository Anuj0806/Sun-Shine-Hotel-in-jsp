<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<%@ include file="config.jsp" %>
<html>
    <head>
        <title>Modify Order</title>
        <link rel="icon" href="./image/hotel-sign.png">
        <link href="./css/tables.css" rel="stylesheet">
        <link rel="stylesheet" href="./css/alert.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <style>
            .button-70 {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .button-70:disabled {
                background-color: #ccc;
            }
        </style>
    </head>
        <%
         if (session.getAttribute("email") == null) {
                response.sendRedirect("guest_login_signup_page.html#cover");
            }
    %>
    <body>
        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>
                <li class="items"><a>Modify Order</a></li>
                <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
            </ul>
        </nav>
        <div class="container">
            <table>
                <tr style="position: sticky; z-index: 5;">
                    <th>Order ID</th>
                    <th>Guest Name</th>
                    <th>Order Date</th>
                    <th>Status</th>
                    <th>Total Price</th>
                    <th>Items</th>
                    <th>Action</th>
                </tr>
                <%
                    String guest_id = String.valueOf(session.getAttribute("guest_id"));
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    PreparedStatement itemsPstmt = null;
                    PreparedStatement menuStmt = null;
                    ResultSet rsItems = null;

                    try {
                        Class.forName(driver);
                        conn = DriverManager.getConnection(url, user, password1);
                        String sql = "SELECT o.order_id, o.guest_id, o.order_date, o.status, o.total_price, g.name "
                                + "FROM orders o "
                                + "JOIN guest g ON o.guest_id = g.guest_id "
                                + "WHERE o.status NOT LIKE ? AND TIMESTAMPDIFF(MINUTE, order_date, NOW()) <= 5 and g.guest_id=?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, "%confirm%");
                        pstmt.setString(2, guest_id);
                        rs = pstmt.executeQuery();
                        boolean found_order = rs.next();
                        if (!found_order) {
                        %>
                        <script>
                            alert("No Order is booked by the guest.");
                            window.location = "guestloginpage.jsp";
                        </script>
                        <%
                } else {
                    while (rs.next()) {
                        int orderId = rs.getInt("order_id");
                        String guestName = rs.getString("name");
                        String orderDate = rs.getString("order_date");
                        String status = rs.getString("status");
                        double totalPrice = rs.getDouble("total_price");
                %>
                <tr data-order-id="<%= orderId%>">
                    <td><%= orderId%></td>
                    <td><%= guestName%></td>
                    <td><%= orderDate%></td>
                    <td><%= status%></td>
                    <td>$<%= totalPrice%></td>
                    <td>
                        <table>
                            <tr>
                                <th>Item ID</th>
                                <th>Item Name</th>
                                <th>Quantity</th>
                                <th>Price</th>
                            </tr>
                            <%
                                String itemsSql = "SELECT oi.item_id, m.item_name, oi.quantity, (oi.quantity * m.price) AS price "
                                        + "FROM order_items oi "
                                        + "JOIN menu m ON oi.item_id = m.item_id "
                                        + "WHERE oi.order_id = ?";
                                itemsPstmt = conn.prepareStatement(itemsSql);
                                itemsPstmt.setInt(1, orderId);
                                rsItems = itemsPstmt.executeQuery();

                                while (rsItems.next()) {
                            %>
                            <tr>
                                <td><%= rsItems.getInt("item_id")%></td>
                                <td>
                                    <select id="item_<%= rsItems.getInt("item_id")%>">
                                        <option value="<%= rsItems.getInt("item_id")%>"><%= rsItems.getString("item_name")%></option>
                                        <%
                                            String menuSql = "SELECT item_id, item_name FROM menu";
                                            menuStmt = conn.prepareStatement(menuSql);
                                            ResultSet menuRs = menuStmt.executeQuery(menuSql);
                                            while (menuRs.next()) {
                                                if (menuRs.getInt("item_id") != rsItems.getInt("item_id")) {
                                        %>
                                        <option value="<%= menuRs.getInt("item_id")%>"><%= menuRs.getString("item_name")%></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </td>
                                <td><input type="number" id="quantity_<%= rsItems.getInt("item_id")%>" min="1"  value="<%= rsItems.getInt("quantity")%>" /></td>
                                <td>$<%= rsItems.getDouble("price")%></td>
                            </tr>
                            <%
                                }
                            %>
                        </table>
                    </td>
                    <td>
                        <button class="button-70" onclick="modifyOrder(<%= orderId%>)">Modify Order</button>
                        <button class="button-70" onclick="modifyOrder(<%= orderId%>, true)">Cancel Order</button>
                    </td>
                </tr>

                <%
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rsItems != null) {
                            try {
                                rsItems.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (itemsPstmt != null) {
                            try {
                                itemsPstmt.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (rs != null) {
                            try {
                                rs.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (pstmt != null) {
                            try {
                                pstmt.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (conn != null) {
                            try {
                                conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                %>
            </table>
        </div>
        <script>

            $(document).ready(function () {
                $("input[type='number']").on("input", function () {
                    if ($(this).val() < 1) {
                        $(this).val(1);
                    }
                });
            });

            function modifyOrder(orderId, isCancel) {
                var itemsMap = {};

                // Iterate over each table row for the given order
                $("tr[data-order-id='" + orderId + "'] table tr").each(function () {
                    var itemId = $(this).find("select").val();
                    var quantity = $(this).find("input[type=number]").val();

                    if (itemId && quantity) {
                        if (itemsMap[itemId]) {
                            itemsMap[itemId].quantity += parseInt(quantity);
                        } else {
                            itemsMap[itemId] = {itemId: itemId, quantity: parseInt(quantity)};
                        }
                    }
                });

                var items = Object.values(itemsMap);

                $.ajax({
                    type: "POST",
                    url: "modifyOrder.jsp",
                    data: {
                        orderId: orderId,
                        items: JSON.stringify(items),
                        isCancel: isCancel // New parameter indicating cancellation
                    },
                    success: function (response) {
                        alert(response.message);
                        console.log(response);
                        if (response.status === "success") {
                            location.reload();
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error(xhr.responseText);
                    }
                });
            }



        </script>
    </body>
</html>
