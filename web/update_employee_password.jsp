<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            String otp1 = (String) session.getAttribute("user");
            if (otp.equals(otp1)) {
                try {
                    Class.forName(driver);
                    java.sql.Connection conn = DriverManager.getConnection(url, user, password1);
                    String sql = "update employee set password=? where email=?";
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
                    out.print(e);
                }
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Your password is successfully updated Please login');");
                out.println("location='employeelogin.html';");
                out.println("</script>");

            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Your OTP is not Matched');");
                out.println("location='change_new_password_otp_employee.jsp';");
                out.println("</script>");
            }
        %>
    </body>
</html>
