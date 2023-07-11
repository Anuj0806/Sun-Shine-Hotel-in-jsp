<%-- 
    Document   : update_employee_data
    Created on : 19-Mar-2023, 8:52:58 am
    Author     : Jitender
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.awt.HeadlessException"%>
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
      String id=String.valueOf(session.getAttribute("id"));
      String name=request.getParameter("name");
      String address=request.getParameter("add");
      String phone=request.getParameter("number");
      String email=request.getParameter("email");
//      out.println(name);
//      out.println(id);
//      out.println(address);
//      out.println(phone);
//      out.println(email);
     
 try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try ( java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$")) {
                    String sql = "update employee set name=?,address=?,phone=?,email=? where employeeid='"+id+"'";
                    PreparedStatement ptst = conn.prepareStatement(sql);
                    ptst.setString(1,name);                   
                    ptst.setString(2, address);
                    ptst.setString(3, phone);
                    ptst.setString(4, email);                                 
                    ptst.executeUpdate();
                    out.println("<script type=\"text/javascript\">"); 
                out.println("alert('Your data is suceesfully updated');"); 
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
