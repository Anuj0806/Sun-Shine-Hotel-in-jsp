
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.lang.String"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    
        
        <%!
            String mail1;
            String otp;
            
 public int generate(String mail)
            {
           this.mail1=mail;   
          
            Random rand=new Random();
         otp=String.valueOf(rand.nextInt(999999));
                String message = "For Change Employee Password\n your otp is :- "+otp;
		String subject = "Sun Shine Hotel";
		String to = mail1;
		String from = "anuj9896388147@gmail.com";

	sendEmail(message,subject,to,from);
return Integer.valueOf(otp);
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
           String name=request.getParameter("name");          
           String mail=request.getParameter("email"); 
           
           
           
           try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                String sql = "select email from employee";
                PreparedStatement pst = conn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                 while (rs.next()) {
                    
                    String mail1= rs.getString("email");
                    if(mail1.endsWith(mail)){
                      String otp1=String.valueOf(generate(mail));  
                    session.setAttribute("user", otp1);
                      session.setAttribute("msg", "OTP is successfully send on your Email");                                     
                     session.setAttribute("name", name);          
                    session.setAttribute("email", mail);                   
                   response.sendRedirect("change_new_password_otp_employee.jsp");
                   
                    }                                      
                 else{
                 out.println("<script type=\"text/javascript\">"); 
                out.println("alert('Your email is not Found in our system');"); 
                out.println("location='change_new_password_employee.jsp';"); 
                out.println("</script>"); 
                     
                 }
            }
                 
            } catch (Exception e) {
                out.println("<script type=\"text/javascript\">"); 
                out.println("alert('Your email is already register in our system');"); 
                out.println("location='guestlogin.html';"); 
                out.println("</script>"); 
            }
           
            

//                   out.println("<script type=\"text/javascript\">"); 
//                   out.println("alert('OTP is successfully send on your Email');"); 
//                   out.println("location='verifyotp.html';"); 
//                   out.println("</script>");             

            %>
            
    

