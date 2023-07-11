<%-- 
    Document   : guestlogin
    Created on : 18-Mar-2023, 9:30:42 am
    Author     : Jitender
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
             String email=request.getParameter("email");
             session.setAttribute("email", email);
             String password=request.getParameter("password");
             try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                String sql = "select Email,Password from guest where Email=? and Password=?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, email);
                pst.setString(2, password);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {

                    out.println("<script type=\"text/javascript\">"); 
                    out.println("alert('Welcome User');"); 
                    out.println("location='guestloginpage.html';"); 
                    out.println("</script>"); 
                    
                } else {
                     out.println("<script type=\"text/javascript\">"); 
                    out.println("alert('Email and Password is not Matched');"); 
                    out.println("location='guest_login_signup_page.html';"); 
                    out.println("</script>"); 
                }
                con.close();

            } catch (Exception e) {
                JOptionPane.showMessageDialog(null, e);
            }
            

            %>
    </body>
</html>
