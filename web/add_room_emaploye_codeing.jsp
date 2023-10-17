<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
   <body>
       
        <%!
         ArrayList arr = new ArrayList();
          ArrayList arr1 = new ArrayList();
        
        %>
        
        <%
         String no=request.getParameter("room_no");
          String clas=request.getParameter("Room_Class");
           String beds=request.getParameter("Room_Beds");
          String floor=request.getParameter("floor");
         String type=request.getParameter("type");
          String price=request.getParameter("price");
         
          try {
                Class.forName(driver);
                java.sql.Connection conn = DriverManager.getConnection(url,user, password1);
                String sql = "select room_no from duplicateroom";
                PreparedStatement pst = conn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                while (rs.next()) {
                    String room = rs.getString("room_no");                   
                    arr1.add(room);                        
            }
               
                conn.close();               
            } catch (Exception e) {
            out.print(e);
            }
        //=====================================================================         
          
          try {
                Class.forName(driver);
                java.sql.Connection conn = DriverManager.getConnection(url, user, password1);
                String sql = "select room_no from demoroom";
                PreparedStatement pst = conn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                while (rs.next()) {
                    String room = rs.getString("room_no");                   
                    arr.add(room);                        
            }
               
                conn.close();               
            } catch (Exception e) {
            out.print(e);
            }
            //=======================================================================
            if(arr1.contains(no)){
             arr1.clear();
                    out.println("<script type=\"text/javascript\">"); 
                    out.println("alert('Room no is already exist');"); 
                   out.println("location='employee_login_page.html';"); 
                   out.println("</script>");  
            }
            else{
                    if (arr.contains(no)) {                      
                    arr.clear();
                    out.println("<script type=\"text/javascript\">"); 
                    out.println("alert('Room no is already exist');"); 
                   out.println("location='employee_login_page.html';"); 
                   out.println("</script>");  
                   
                    }                     
                    else
                    {
 try {
                Class.forName(driver);
                java.sql.Connection con = DriverManager.getConnection(url,user, password1);
                String sql1 = "insert into room values(?,?,?,?,?,?)";               
                PreparedStatement ptst = con.prepareStatement(sql1);
                ptst.setString(1, no);
                ptst.setString(2, clas);
                ptst.setString(3, beds);                                          
                ptst.setString(4, floor);             
                ptst.setString(5, type);
                ptst.setString(6, price);               
                ptst.executeUpdate();                
                con.close();
                  out.println("<script type=\"text/javascript\">"); 
                    out.println("alert('Room added suceesfully');"); 
                   out.println("location='employee_login_page.html';"); 
                   out.println("</script>"); 
                

            } 
            catch (Exception e) {
                    out.println("<script type=\"text/javascript\">"); 
                    out.println("alert('Room no is already register');"); 
                   out.println("location='employee_login_page.html';"); 
                   out.println("</script>"); 
            }            
          }
            }
             
        %>
    </body>
</html>
