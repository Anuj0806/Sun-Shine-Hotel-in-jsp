<%@include file="config.jsp" %>
<html>
    <head>
              <title>JSP Page</title>
    </head>
    <body>
        <%!            public void approve(String email) {
                String message = "Hi " + email + "\nYour room is booked Sucessfully\n Thankyou for choosing us. We are very greatfull";
                String subject = "Sun Shine Hotel";
                String to = email;
                String from = "anuj9896388147@gmail.com";
                sendEmail(message, subject, to, from);
            }
            private static void sendEmail(String message, String subject, String to, String from) {
                String host = "smtp.gmail.com";
                Properties proper = new Properties();
                proper.setProperty("mail.smtp.host", host);
                proper.setProperty("mail.smtp.port", "465");
                proper.setProperty("mail.smtp.ssl.enable", "true");
                proper.setProperty("mail.smtp.auth", "true");
                Session session = Session.getInstance(proper, new Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(emailUsername, emailPassword);
                    }
                });
                session.setDebug(true);
                MimeMessage m = new MimeMessage(session);
                try {
                    m.setFrom(from);
                    m.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                    m.setSubject(subject);
                    m.setText(message);
                    Transport.send(m);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
        <%
            String room = request.getParameter("room");
            String email = "";
            String clas = "";
            String bed = "";
            String floor = "";
            String ac = "";
            String price = "";
            String checkin = "";
            String checkout = "";
            String description = "";
            Blob photo = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(url, user, password1);
                PreparedStatement ps = con.prepareStatement("select * from duplicateroom where room_no='" + room + "'");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    clas = rs.getString("class");
                    bed = rs.getString("beds");
                    floor = rs.getString("floor");
                    ac = rs.getString("nonac");
                    price = rs.getString("prize");
                    description = rs.getString("Description");
                    photo = rs.getBlob("photo");
                    checkin = rs.getString("checkin");
                    checkout = rs.getString("checkout");
                    email = rs.getString("email");
                }
                con.close();
                rs.close();
                ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            out.print(description);
            try {
                Class.forName(driver);
                java.sql.Connection conn = DriverManager.getConnection(url, user, password1);
                String sql = "insert into reservation values(?,?,?)";
                PreparedStatement ptst = conn.prepareStatement(sql);
                ptst.setString(1, room);
                ptst.setString(2, checkin);
                ptst.setString(3, checkout);
                ptst.executeUpdate();
                conn.close();
            } catch (Exception e) {
                out.print(e);
            }
            //=---------------------------------------------------------------------------------
            try {
                Class.forName(driver);
                java.sql.Connection conn = DriverManager.getConnection(url, user, password1);
                String sql = "insert into demoroom values(?,?,?,?,?,?,?,?)";
                PreparedStatement ptst = conn.prepareStatement(sql);
                ptst.setString(1, room);
                ptst.setString(2, clas);
                ptst.setString(3, bed);
                ptst.setString(4, floor);
                ptst.setString(5, ac);
                ptst.setString(6, price);
                ptst.setString(7, description);
                ptst.setBlob(8, photo);
                ptst.executeUpdate();
                conn.close();
            } catch (Exception e) {
                out.print(e);
            }
            //=========================================================================
            String con = "Confrimed...";
            String wait = "Waiting........";
            try {
                Class.forName(driver);
                java.sql.Connection conn = DriverManager.getConnection(url, user, password1);
                String sql = "update status set status=? where Status='" + wait + "' and room_no='" + room + "' ";
                PreparedStatement ptst = conn.prepareStatement(sql);
                ptst.setString(1, con);
                ptst.executeUpdate();
                conn.close();
            } catch (Exception e) {
                out.print(e);
            }
            //========================================================================================
            try {
                Class.forName(driver);
                java.sql.Connection conn = DriverManager.getConnection(url, user, password1);
                String sql = "update payment set status=? where Status='" + wait + "' and room_no='" + room + "' ";
                PreparedStatement ptst = conn.prepareStatement(sql);
                ptst.setString(1, con);
                ptst.executeUpdate();
                conn.close();
            } catch (Exception e) {
                out.print(e);
            }
            //========================================================================================
            try {
                Class.forName(driver);
                Connection conn = DriverManager.getConnection(url, user, password1);
                String sql = "delete from duplicateroom where room_no='" + room + "'";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.execute();
            } catch (Exception e) {
                out.print(e);
            }
//            approve(email);
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Room Aproved Suceessfully');");
            out.println("location='employee_login_page.html';");
            out.println("</script>");
        %>
    </body>
</html>
