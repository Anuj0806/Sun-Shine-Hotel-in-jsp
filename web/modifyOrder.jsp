<%@ page import="java.sql.*, org.json.*" %>
<%@ include file="config.jsp" %>
    <%
        if (session.getAttribute("email") == null) {
                response.sendRedirect("guest_login_signup_page.html#cover");
            }
    %>
<%
    String orderId = request.getParameter("orderId");
    String itemsJson = request.getParameter("items");
    boolean isCancel = Boolean.parseBoolean(request.getParameter("isCancel"));

    Connection conn = null;
    PreparedStatement pstmtDeleteItems = null;
    PreparedStatement pstmtDeleteOrder = null;
    PreparedStatement pstmtInsertItems = null;
    PreparedStatement pstmtUpdateTotalPrice = null;
    JSONObject jsonResponse = new JSONObject();

    try {
        Class.forName(driver);
        conn = DriverManager.getConnection(url, user, password1);

        if (isCancel) {
            // Delete items if order is canceled
            String deleteItemsSql = "DELETE FROM order_items WHERE order_id = ?";
            pstmtDeleteItems = conn.prepareStatement(deleteItemsSql);
            pstmtDeleteItems.setInt(1, Integer.parseInt(orderId));
            pstmtDeleteItems.executeUpdate();

            // Delete the order itself
            String deleteOrderSql = "DELETE FROM orders WHERE order_id = ?";
            pstmtDeleteOrder = conn.prepareStatement(deleteOrderSql);
            pstmtDeleteOrder.setInt(1, Integer.parseInt(orderId));
            pstmtDeleteOrder.executeUpdate();

            jsonResponse.put("status", "success");
            jsonResponse.put("message", "Order Cancel successfully!");
        } else {
            JSONArray itemsArray = new JSONArray(itemsJson);

            // Delete existing items
            String deleteItemsSql = "DELETE FROM order_items WHERE order_id = ?";
            pstmtDeleteItems = conn.prepareStatement(deleteItemsSql);
            pstmtDeleteItems.setInt(1, Integer.parseInt(orderId));
            pstmtDeleteItems.executeUpdate();
           
                // Insert new items
                String insertItemsSql = "INSERT INTO order_items (order_id, item_id, quantity) VALUES (?, ?, ?)";
                pstmtInsertItems = conn.prepareStatement(insertItemsSql);

                double totalPrice = 0.0;

                for (int i = 0; i < itemsArray.length(); i++) {
                    JSONObject item = itemsArray.getJSONObject(i);
                    int itemId = item.getInt("itemId");
                    int quantity = item.getInt("quantity");

                    pstmtInsertItems.setInt(1, Integer.parseInt(orderId));
                    pstmtInsertItems.setInt(2, itemId);
                    pstmtInsertItems.setInt(3, quantity);
                    pstmtInsertItems.addBatch();

                    // Calculate total price
                    String itemPriceSql = "SELECT price FROM menu WHERE item_id = ?";
                    PreparedStatement pstmtItemPrice = conn.prepareStatement(itemPriceSql);
                    pstmtItemPrice.setInt(1, itemId);
                    ResultSet rsItemPrice = pstmtItemPrice.executeQuery();
                    if (rsItemPrice.next()) {
                        double itemPrice = rsItemPrice.getDouble("price");
                        totalPrice += itemPrice * quantity;
                    }
                    rsItemPrice.close();
                    pstmtItemPrice.close();
                }

                pstmtInsertItems.executeBatch();

                // Update the total price in orders table
                String updateTotalPriceSql = "UPDATE orders SET total_price = ? WHERE order_id = ?";
                pstmtUpdateTotalPrice = conn.prepareStatement(updateTotalPriceSql);
                pstmtUpdateTotalPrice.setDouble(1, totalPrice);
                pstmtUpdateTotalPrice.setInt(2, Integer.parseInt(orderId));
                pstmtUpdateTotalPrice.executeUpdate();

                jsonResponse.put("status", "success");
                jsonResponse.put("message", "Order modified successfully!");
            
        }
    } catch (Exception e) {
        e.printStackTrace();
        jsonResponse.put("status", "error");
        jsonResponse.put("message", e.getMessage());
    } finally {
        if (pstmtInsertItems != null) {
            try {
                pstmtInsertItems.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (pstmtDeleteItems != null) {
            try {
                pstmtDeleteItems.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (pstmtDeleteOrder != null) {
            try {
                pstmtDeleteOrder.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (pstmtUpdateTotalPrice != null) {
            try {
                pstmtUpdateTotalPrice.close();
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

    response.setContentType("application/json");
    response.getWriter().write(jsonResponse.toString());
%>
