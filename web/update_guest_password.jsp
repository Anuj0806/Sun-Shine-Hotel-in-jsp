<%-- 
    Document   : update_employee_password
    Created on : 20-Mar-2023, 9:11:32 pm
    Author     : Jitender
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String mail = String.valueOf(session.getAttribute("email"));
            String password = request.getParameter("password");
            String otp = request.getParameter("otp");
            String re_password = request.getParameter("retypepassword");
            String otp1 = (String) session.getAttribute("user");

            if (otp.equals(otp1)) {
            if(password.equals(re_password)){
                try {

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                    String sql = "update guest set password=? where email=?";
                    PreparedStatement ptst = conn.prepareStatement(sql);
                    ptst.setString(1, password);
                    ptst.setString(2, mail);

                    ptst.executeUpdate();

                    conn.close();

                } catch (Exception e) {
                  
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Your email is already register in our system');");
                    out.println("location='guestlogin.html';");
                    out.println("</script>");

                }
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Your password is successfully updated Please login');");
                out.println("location='guest_login_signup_page.html';");
                out.println("</script>");

            
            }
            else{
             out.println("<script type=\"text/javascript\">");
                out.println("alert('Password Not Matched');");
                out.println("location='change_new_password_otp.jsp';");
                out.println("</script>");
            }
            }
            else 
            {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Your OTP is not Matched');");
                out.println("location='change_new_password_otp.jsp';");
                out.println("</script>");
            }


        %>
    </body>
</html>
