<%@include file="config.jsp" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String room = request.getParameter("id");
            try {
                Class.forName(driver);
                java.sql.Connection conn = DriverManager.getConnection(url, user, password1);
                String sql = "select * from demoroom where room_no=?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, room);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    String room1 = rs.getString("room_no");
                    String class1 = rs.getString("class");
                    String beds = rs.getString("beds");
                    String floor = rs.getString("floor");
                    String nonac = rs.getString("ac_nonac");
                    String prize = rs.getString("price");
                    String description = rs.getString("Description");
                    Blob photo = rs.getBlob("photo");
                    try {
                        Class.forName(driver);
                        java.sql.Connection con = DriverManager.getConnection(url, user, password1);
                        String sql1 = "insert into room values(?,?,?,?,?,?,?,?)";
                        PreparedStatement ptst = con.prepareStatement(sql1);
                        ptst.setString(1, room1);
                        ptst.setString(2, class1);
                        ptst.setString(3, beds);
                        ptst.setString(4, floor);
                        ptst.setString(5, nonac);
                        ptst.setString(6, prize);
                        ptst.setString(7, description);
                        ptst.setBlob(8, photo);
                        ptst.executeUpdate();
                        con.close();
                    } catch (Exception e) {
                        out.print(e);
                    }
                } else {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('No Guest Found');");
                    out.println("location='employee_login_page.html';");
                    out.println("</script>");
                }
                conn.close();
            } catch (Exception e) {
                out.print(e);
            }
            try {
                Class.forName(driver);
                java.sql.Connection con = DriverManager.getConnection(url, user, password1);
                String sql = "delete from reservation where room_no=?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, room);
                pst.execute();
            } catch (Exception e) {
                out.print(e);
            }
            //===========================================================================================================
            try {
                Class.forName(driver);
                java.sql.Connection con = DriverManager.getConnection(url, user, password1);
                String sql = "delete from demoroom where room_no=?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, room);
                pst.execute();
            } catch (Exception e) {
                out.print(e);
            }
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Check Out Sucessfully');");
            out.println("location='employee_login_page.html';");
            out.println("</script>");
        %>
    </body>
</html>
