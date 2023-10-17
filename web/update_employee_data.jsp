<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>       
        <%
//  
      String name=request.getParameter("name");
      String address=request.getParameter("add");
      String phone=request.getParameter("number");
      String email=request.getParameter("email");
       String id=request.getParameter("id");
       out.print(id);
//      out.println(name);
//      out.println(id);
//      out.println(address);
//      out.println(phone);
//      out.println(email);     
try{
                  Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, user, password1);
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
                } catch (Exception e) {
                    out.print(e);
                }            
        %>
    </body>
</html>
