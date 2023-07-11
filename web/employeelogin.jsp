<%-- 
    Document   : employeelogin
    Created on : 19-Mar-2023, 9:16:45 pm
    Author     : Jitender
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String name=request.getParameter("email");
             String password=request.getParameter("password");
         try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                String sql = "select email,password from employee where email=? and password=?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, name);
                pst.setString(2, password);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {

                   out.println("<script type=\"text/javascript\">"); 
                   out.println("alert('Welcome Employee');"); 
                   out.println("location='employee_login_page.html';"); 
                   out.println("</script>"); 
                } else {
                   out.println("<script type=\"text/javascript\">"); 
out.println("alert('Email and Password is Wrong');"); 
out.println("location='employeelogin.html';"); 
out.println("</script>"); 
                }
                con.close();

            } catch (Exception e) {
                 out.println("<script type=\"text/javascript\">"); 
out.println("alert('you email is already exist');"); 
out.println("location='employeelogin.html';"); 
out.println("</script>"); 
            }
        
        %>
    </body>
</html>
