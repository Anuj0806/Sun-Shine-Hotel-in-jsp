<%-- 
    Document   : delete_employee
    Created on : 20-Mar-2023, 10:52:02 pm
    Author     : Jitender
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.awt.HeadlessException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String id=request.getParameter("id");          
//      out.println(id);           
 try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try ( java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$")) {
                    String sql = "delete from employee where employeeid='"+id+"'";
                    PreparedStatement ptst = conn.prepareStatement(sql);                                                                                   
                    ptst.executeUpdate();
                    out.println("<script type=\"text/javascript\">"); 
                out.println("alert('Employee deleted suceesfully');"); 
                out.println("location='adminloginpage.jsp';"); 
                out.println("</script>"); 
                } catch (HeadlessException e) {
                    out.print(e);
                }
            } catch (HeadlessException | ClassNotFoundException | SQLException e) {
                //JOptionPane.showMessageDialog(this, "Updated Email is already register in our system");
                //JOptionPane.showMessageDialog(this, e);
                out.print(e);
            }      

        
        %>
    </body>
</html>
