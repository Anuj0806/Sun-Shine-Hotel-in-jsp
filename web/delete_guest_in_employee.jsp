<%@include file="config.jsp" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String id = request.getParameter("id");
            try {
                Class.forName(driver);
                Connection conn = DriverManager.getConnection(url, user, password1);
                String sql = "delete from guest where email='" + id + "'";
                PreparedStatement ptst = conn.prepareStatement(sql);
                ptst.executeUpdate();
                out.println("<script type=\"text/javascript\">");
                out.println("alert('guest deleted suceesfully');");
                out.println("location='show_guest_in _employee.jsp';");
                out.println("</script>");
            } catch (Exception e) {
                out.print(e);
            }


        %>
    </body>
</html>
