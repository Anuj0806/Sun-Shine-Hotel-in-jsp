<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                Class.forName(driver);
                Connection con = DriverManager.getConnection(url,user,password1);
                String sql = "select Email,Password from guest where Email=? and Password=?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, email);
                pst.setString(2, password);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {

                    out.println("<script type=\"text/javascript\">"); 
                    out.println("alert('Welcome User');"); 
                    out.println("location='guestloginpage.jsp';"); 
                    out.println("</script>"); 
                    
                } else {
                     out.println("<script type=\"text/javascript\">"); 
                    out.println("alert('Email and Password is not Matched');"); 
                    out.println("location='guest_login_signup_page.html';"); 
                    out.println("</script>"); 
                }
                con.close();

            } catch (Exception e) {
             out.print(e);
            }
            

            %>
    </body>
</html>
