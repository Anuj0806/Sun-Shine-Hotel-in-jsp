<%-- 
    Document   : approve_room_button_action
    Created on : 26-Mar-2023, 12:18:16 pm
    Author     : Jitender
--%>


<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%!
        public void approve(String email){
 String message = "Hi "+email+"\nYour room is booked Sucessfully\n Thankyou for choosing us. We are very greatfull";
		String subject = "Sun Shine Hotel";
		String to = email;
		String from = "anuj9896388147@gmail.com";

	sendEmail(message,subject,to,from);
                   

	}
	private static void sendEmail(String message, String subject, String to, String from) {
		String host="smtp.gmail.com";
		Properties proper = new Properties();
		proper.setProperty("mail.smtp.host", host);
		proper.setProperty("mail.smtp.port","465");
		proper.setProperty("mail.smtp.ssl.enable","true");
		proper.setProperty("mail.smtp.auth","true");
		Session session=Session.getInstance(proper, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {				
				return new PasswordAuthentication("anuj9896388147@gmail.com","zdkpfmdqwzhxstkg");
			}			
		});
		session.setDebug(true);
		MimeMessage m = new MimeMessage(session);
		try {
		m.setFrom(from);
		m.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
		m.setSubject(subject);
		m.setText(message);
		Transport.send(m);


		}catch (Exception e) {
			e.printStackTrace();
		}

}
        
        %>
       <%
       String email=request.getParameter("email");
       String room=request.getParameter("room");
       String clas=request.getParameter("class");
       String bed=request.getParameter("bed");
       String floor=request.getParameter("floor");
       String ac=request.getParameter("ac");
       String price=request.getParameter("price");
       String checkin=request.getParameter("checkin");
       String checkout=request.getParameter("checkout");
        
       try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                String sql = "insert into reservation values(?,?,?)";               
                PreparedStatement ptst = conn.prepareStatement(sql);               
                ptst.setString(1, room);                                                                           
                ptst.setString(2, checkin);                                                                           
                ptst.setString(3, checkout);                                                                           
                ptst.executeUpdate();                
                conn.close();             
                } catch (Exception e) {
                //out.print(e);
            }              
       //=---------------------------------------------------------------------------------
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                String sql = "insert into demoroom values(?,?,?,?,?,?)";               
                PreparedStatement ptst = conn.prepareStatement(sql);               
                ptst.setString(1, room);                                                            
                ptst.setString(2, clas);                              
                ptst.setString(3, bed);
                ptst.setString(4, floor);
                ptst.setString(5, ac);
                 ptst.setString(6,price);
                ptst.executeUpdate();
                
                conn.close();                             
            } catch (Exception e) {
               
            }
            //=========================================================================
            String con="Confrimed...";
            String wait="Waiting........";
             try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                String sql = "update status set status=? where Email='"+email+"' and Status='"+wait+"' and room_no='"+room+"' ";               
                PreparedStatement ptst = conn.prepareStatement(sql);               
                ptst.setString(1, con);                                                            
                
                ptst.executeUpdate();
                
                conn.close();                             
            } catch (Exception e) {
               
            }
            //========================================================================================
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                String sql = "update payment set status=? where Email='"+email+"' and Status='"+wait+"' and room_no='"+room+"' ";               
                PreparedStatement ptst = conn.prepareStatement(sql);               
                ptst.setString(1, con);                                                                            
                ptst.executeUpdate();
                
                conn.close();                             
            } catch (Exception e) {
               out.print(e);
            }
            //========================================================================================
            
            try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
            String sql = "delete from duplicateroom where room_no='"+room+"'";
            PreparedStatement pst = conn.prepareStatement(sql);            
            pst.execute();
            //JOptionPane.showMessageDialog(this, "Data deleted sucessfully");
                   } catch (Exception e) {
          //  JOptionPane.showMessageDialog(this, e);
        }
              approve(email);     
                    out.println("<script type=\"text/javascript\">"); 
                    out.println("alert('Room Aproved Suceessfully');"); 
                   out.println("location='employee_login_page.html';"); 
                    out.println("</script>"); 
       
            
      
       
       %>
    </body>
</html>
