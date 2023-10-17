<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String otp = request.getParameter("username");
            String otp1 = (String) session.getAttribute("user");
            String name = (String) session.getAttribute("name");
            String mobile = (String) session.getAttribute("mobile");
            String area = (String) session.getAttribute("area");
            String email = (String) session.getAttribute("email");
            String password = (String) session.getAttribute("password");
            if (otp.equals(otp1)) {
                try {
                    Class.forName(driver);
                    java.sql.Connection conn = DriverManager.getConnection(url, user, password1);
                    String sql = "insert into guest values(?,?,?,?,?)";
                    PreparedStatement ptst = conn.prepareStatement(sql);
                    ptst.setString(1, name);
                    ptst.setString(2, mobile);
                    ptst.setString(3, area);
                    ptst.setString(4, email);
                    ptst.setString(5, password);
                    ptst.executeUpdate();
                    conn.close();
                } catch (Exception e) {
                    out.print(e);
                }
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Account create Succesfully please Login');");
                out.println("location='guest_login_signup_page.html';");
                out.println("</script>");

            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Your OTP is not Matched');");
                out.println("location='verifyotp_guest_text.jsp';");
                out.println("</script>");
            }
        %>
    </body>
</html>
