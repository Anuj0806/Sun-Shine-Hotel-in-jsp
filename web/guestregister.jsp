
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.lang.String"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>


<%!
    String mail1;
    String otp;

    public int generate(String mail) {
        this.mail1 = mail;

        Random rand = new Random();
        otp = String.valueOf(rand.nextInt(999999));
        String message = "your otp is :- " + otp;
        String subject = "Sun Shine Hotel";
        String to = mail1;
        String from = "anuj9896388147@gmail.com";

        sendEmail(message, subject, to, from);
        return Integer.valueOf(otp);
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
                return new PasswordAuthentication("anuj9896388147@gmail.com", "zdkpfmdqwzhxstkg");
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




<%!
    ArrayList arr = new ArrayList();
%>
<%
    String name = request.getParameter("name");
    String mobile = request.getParameter("phone");
    String area = request.getParameter("address");
    String mail = request.getParameter("email");
    String password = request.getParameter("password");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
        String sql = "select email from guest";
        PreparedStatement pst = conn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            String room = rs.getString("email");
            arr.add(room);
        }
        conn.close();
    } catch (Exception e) {
        out.print(e);
    }

    if (arr.contains(mail)) {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Your email is already register');");
        out.println("location='guest_login_signup_page.html';");
        out.println("</script>");
    } else {
        arr.clear();
        String otp1 = String.valueOf(generate(mail));

        session.setAttribute("name", name);
        session.setAttribute("mobile", mobile);
        session.setAttribute("area", area);
        session.setAttribute("email", mail);
        session.setAttribute("password", password);
        session.setAttribute("user", otp1);
        session.setAttribute("msg", "OTP is successfully send on your Email");
        response.sendRedirect("verifyotp_guest_text.jsp");

//                   out.println("<script type=\"text/javascript\">"); 
//                   out.println("alert('OTP is successfully send on your Email');"); 
//                   out.println("location='verifyotp.html';"); 
//                   out.println("</script>");  
    }

%>



