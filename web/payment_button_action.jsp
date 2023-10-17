<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%!            ArrayList arr = new ArrayList();
        %>
        <%
            String current_date = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
            String email = String.valueOf(session.getAttribute("email"));
            //////ajbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
            String room_no = String.valueOf(session.getAttribute("room_no"));
            String clas = "";
            String bed = "";
            String floor = "";
            String ac = "";
            String price = "";
                 String description = "";
                   Blob  photo=null;
                      
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(url, user, password1);
                PreparedStatement ps = con.prepareStatement("select * from room where room_no='" + room_no + "'");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    clas = rs.getString("class");
                    bed = rs.getString("beds");
                    floor = rs.getString("floor");
                    ac = rs.getString("ac_nonac");
                    price = rs.getString("prize");
                       description = rs.getString("Description");
                   photo = rs.getBlob("photo");
                }
                con.close();
                rs.close();
                ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

            String checkin = request.getParameter("checkin");
            String checkout = request.getParameter("checkout");
            //====================================================================
            String holder_name = request.getParameter("holder_name");
            String card_number = request.getParameter("number");
            String exp_date = request.getParameter("cc_exp_mo");
            String exp_month = exp_date.substring(5, 7);
            String exp_year = exp_date.substring(0, 4);
            String cvv = request.getParameter("cvv");
            String pricenew = request.getParameter("price");

            //===================================================================================
            //=====================================================================================//     
            if (checkout.compareTo(checkin) > 0) {
                String wait = "Waiting........";

                try {
                    Class.forName(driver);
                    java.sql.Connection conn = DriverManager.getConnection(url, user, password1);
                    String sql = "insert into duplicateroom values(?,?,?,?,?,?,?,?,?,?,?)";
                    PreparedStatement ptst = conn.prepareStatement(sql);
                    ptst.setString(1, email);
                    ptst.setString(2, room_no);
                    ptst.setString(3, clas);
                    ptst.setString(4, bed);
                    ptst.setString(5, floor);
                    ptst.setString(6, ac);
                    ptst.setString(7, price);
                    ptst.setString(8, description);
                    ptst.setBlob(9, photo);
                    ptst.setString(10, checkin);
                    ptst.setString(11, checkout);
                    ptst.executeUpdate();
                    conn.close();
                } catch (Exception e) {
                    out.print(e);
                }

                try {
                    Class.forName(driver);
                    java.sql.Connection conn = DriverManager.getConnection(url, user, password1);
                    String sql = "insert into status values(?,?,?,?,?,?,?,?)";
                    PreparedStatement ptst = conn.prepareStatement(sql);
                    ptst.setString(1, email);
                    ptst.setString(2, room_no);
                    ptst.setString(3, clas);
                    ptst.setString(4, bed);
                    ptst.setString(5, floor);
                    ptst.setString(6, ac);
                    ptst.setString(7, pricenew);
                    ptst.setString(8, wait);
                    ptst.executeUpdate();
                    conn.close();
                } catch (Exception e) {
                    out.print(e);
                }

                try {
                    Class.forName(driver);
                    java.sql.Connection conn = DriverManager.getConnection(url, user, password1);
                    String sql = "insert into payment values(?,?,?,?,?,?,?,?)";
                    PreparedStatement ptst = conn.prepareStatement(sql);
                    ptst.setString(1, email);
                    ptst.setString(2, card_number);
                    ptst.setString(3, cvv);
                    ptst.setString(4, exp_month);
                    ptst.setString(5, exp_year);
                    ptst.setString(6, holder_name);
                    ptst.setString(7, wait);
                    ptst.setString(8, room_no);
                    ptst.executeUpdate();
                    conn.close();
//                     welcome_update();
                } catch (Exception e) {
                    out.print(e);
                }

                try {
                    Class.forName(driver);
                    Connection conn = DriverManager.getConnection(url, user, password1);
                    String sql = "delete from room where room_no='" + room_no + "'";
                    PreparedStatement ptst = conn.prepareStatement(sql);
                    ptst.execute();
                } catch (Exception e) {
                    out.print(e);
                }

                out.println("<script type=\"text/javascript\">");
                out.println("alert('Your Request Will be procees in 2 hour');");
                out.println("location='guestloginpage.jsp';");
                out.println("</script>");

            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Check Out Detail is wrong');");
                out.println("location='book_room_button_action.jsp';");
                out.println("</script>");
            }
        %>
    </body>
</html>
