<%-- 
    Document   : check_out
    Created on : 26-Mar-2023, 2:32:50 pm
    Author     : Jitender
--%>

<%@page import="java.sql.ResultSet"%>
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
        String room=request.getParameter("id");
         try {
                
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                String sql = "select room_no,class,beds,floor,ac_nonac,price from demoroom where room_no=?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, room);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    String room1 = rs.getString("room_no");
                    String class1 = rs.getString("class");
                    String beds = rs.getString("beds");
                    String floor = rs.getString("floor");
                    String nonac = rs.getString("ac_nonac");
                    String prize = rs.getString("price");
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                        String sql1 = "insert into room values(?,?,?,?,?,?)";
                        PreparedStatement ptst = conn.prepareStatement(sql1);
                        ptst.setString(1, room1);
                        ptst.setString(2, class1);
                        ptst.setString(3, beds);
                        ptst.setString(4, floor);
                        ptst.setString(5, nonac);
                        ptst.setString(6, prize);
                        ptst.executeUpdate();
                       
                        conn.close();
                    } catch (Exception e) {
                       
                    }
                     } else {
                 //   JOptionPane.showMessageDialog(null, "No Guest Found");
                }
                      } catch (Exception e) {
               
            }
            

 try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                String sql = "delete from reservation where room_no=?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, room);
                pst.execute();
                //JOptionPane.showMessageDialog(this, "Data deleted sucessfully");

            } catch (Exception e) {
                //JOptionPane.showMessageDialog(this, e);
            }
            //===========================================================================================================
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                String sql = "delete from demoroom where room_no=?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, room);
                pst.execute();
                //JOptionPane.showMessageDialog(this, "You sucessfully Checked Out");

            } catch (Exception e) {
               // JOptionPane.showMessageDialog(this, e);
            }
            out.println("<script type=\"text/javascript\">"); 
                out.println("alert('Check Out Sucessfully');"); 
                out.println("location='employee_login_page.html';"); 
                out.println("</script>");
        %>
    </body>
</html>
