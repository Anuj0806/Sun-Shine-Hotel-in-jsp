<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%!            public static void generate(String email, String password) {
                String pass = password;
                String message = "\t\t\t\t\t\t\t\tCongratulations! You are appointed as a new staff member of our hotel."
                        + "\n\n\t\t\t\t\t\t\t\tYour Email id is :-\t\t\t\t" + email
                        + "\n\t\t\t\t\t\t\t\tYour Password is :-\t\t\t\t" + pass;
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
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("number");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            try {
                Class.forName(driver);
                java.sql.Connection conn = DriverManager.getConnection(url, user, password1);
                String sql = "insert into employee values(?,?,?,?,?,?)";
                PreparedStatement ptst = conn.prepareStatement(sql);
                ptst.setString(1, id);
                ptst.setString(2, name);
                ptst.setString(3, address);
                ptst.setString(4, phone);
                ptst.setString(5, email);
                ptst.setString(6, password);
                ptst.executeUpdate();
                conn.close();
                generate(email, password);
                response.sendRedirect("adminloginpage.html");
            } catch (Exception e) {
                out.print(e);
                response.sendRedirect("addemployee.jsp?msg=invalid");
            }
        %>
    </body>
</html>
