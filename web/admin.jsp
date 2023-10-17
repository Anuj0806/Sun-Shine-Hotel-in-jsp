<%@include file="config.jsp" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String name = request.getParameter("email");
            String anuj = request.getParameter("password");
            try {
                Class.forName(driver);
                Connection con = DriverManager.getConnection(url, user, password1);
                String sql = "select * from admin where email=? and password=?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, name);
                pst.setString(2, anuj);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Welcom Admin');");
                    out.println("location='adminloginpage.html';");
                    out.println("</script>");
                } else {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Email and Password not Matched');");
                    out.println("location='admin.html';");
                    out.println("</script>");
                }
                con.close();
            } catch (Exception e) {
                out.print(e);
            }
        %>
    </body>
</html>
