<%-- 
    Document   : payment_button_action
    Created on : 26-Mar-2023, 8:17:28 am
    Author     : Jitender
--%>


<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%!
         ArrayList arr = new ArrayList();
        %>
        
        
        
        <%
            
            
            
            
             String current_date = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
            
            String email=String.valueOf(session.getAttribute("email"));
           
            //////ajbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
            String room_no=String.valueOf(session.getAttribute("room_no"));
            String clas=String.valueOf(session.getAttribute("class"));
            String bed=String.valueOf(session.getAttribute("bed"));
            String floor=String.valueOf(session.getAttribute("floor"));
            String ac=String.valueOf(session.getAttribute("ac"));
            String price=String.valueOf(session.getAttribute("price"));
            String checkin=request.getParameter("checkin");
            String checkout=request.getParameter("checkout");
            //====================================================================
            String holder_name=request.getParameter("holder_name");
            String card_number=request.getParameter("number");
            String exp_month=request.getParameter("cc_exp_mo");
            String exp_year=request.getParameter("cc_exp_yr");
            String cvv=request.getParameter("cvv");  
            String pricenew=request.getParameter("price");  
            
            //===================================================================================
           
            
            //=====================================================================================
     if(checkin.compareTo(current_date) > 0){
     if(checkout.compareTo(checkin) > 0) 
     {
      String wait="Waiting........";
      
    try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                String sql = "insert into duplicateroom values(?,?,?,?,?,?,?,?,?)";               
                PreparedStatement ptst = conn.prepareStatement(sql);               
                ptst.setString(1,email );                                                            
                ptst.setString(2,room_no );                              
                ptst.setString(3,clas );
                ptst.setString(4, bed);
                ptst.setString(5,floor );
                 ptst.setString(6,ac);
                 ptst.setString(7,price);
                 ptst.setString(8, checkin);
                 ptst.setString(9, checkout);
                ptst.executeUpdate();
                //JOptionPane.showMessageDialog(this, "Room Booked succesfully");
                conn.close();                             
            } catch (Exception e) {
                //JOptionPane.showMessageDialog(this, "This room numner is already exist");               
            }
            
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                String sql = "insert into status values(?,?,?,?,?,?,?,?)";               
                PreparedStatement ptst = conn.prepareStatement(sql);               
                ptst.setString(1,email);                                                            
                ptst.setString(2,room_no);                              
                ptst.setString(3,clas);
                ptst.setString(4, bed);
                ptst.setString(5,floor);
                 ptst.setString(6,ac);
                 ptst.setString(7,pricenew);
                 ptst.setString(8,wait);
                
                ptst.executeUpdate();
                //JOptionPane.showMessageDialog(this, "Room Booked succesfully");
                conn.close();                             
            } catch (Exception e) {
               out.print(e);
            }
            
           
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                String sql = "insert into payment values(?,?,?,?,?,?,?,?)";               
                PreparedStatement ptst = conn.prepareStatement(sql);               
                ptst.setString(1,email );                                                            
                ptst.setString(2,card_number );                              
                ptst.setString(3,cvv);
                ptst.setString(4, exp_month);
                ptst.setString(5, exp_year);
                ptst.setString(6, holder_name);
                ptst.setString(7, wait);
                 ptst.setString(8, room_no);
                ptst.executeUpdate();              
                conn.close();
               // welcome_update();
                } catch (Exception e) {
               // JOptionPane.showMessageDialog(this, e);
                //nul();
            }    
            
            
            
      try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
            String sql = "delete from room where room_no='"+room_no+"'";
            PreparedStatement ptst = conn.prepareStatement(sql);           
            ptst.execute();
            } catch (Exception e) {
            //JOptionPane.showMessageDialog(this, e);
        }
        
        
       
        
        
        
        
        
  
      out.println("<script type=\"text/javascript\">"); 
                    out.println("alert('Your Request Will be procees in 2 hour');"); 
                   out.println("location='guestloginpage.html';"); 
                    out.println("</script>"); 
     
     
     
     
     
            }
            else{
            out.println("<script type=\"text/javascript\">"); 
                    out.println("alert('Check Out Detail is wrong');"); 
                   out.println("location='book_room_button_action.jsp';"); 
                    out.println("</script>"); 
            }
            }
            else{
            out.println("<script type=\"text/javascript\">"); 
                    out.println("alert('Check In Detail is Wrong');"); 
                   out.println("location='book_room_for_guest.jsp';"); 
                    out.println("</script>"); 
            }


        %>
    </body>
</html>
