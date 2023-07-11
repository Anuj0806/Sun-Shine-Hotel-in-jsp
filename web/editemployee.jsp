<%-- 
    Document   : editemployee
    Created on : 18-Mar-2023, 8:13:36 pm
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body{
                background-color:  #70c666;;
            }
            .card-body {
    flex: 1 1 auto;
    padding: var(--bs-card-spacer-y) var(--bs-card-spacer-x);
    color: var(--bs-card-color);
    background-color: lightgreen;
}
        </style>
    </head>
   
    <body>

    

           
                <%
                    

              String id=request.getParameter("id");
              session.setAttribute("id", id);
                    try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
                    String sql = "select name,address,phone,email from employee where employeeid='"+id+"'";
                    PreparedStatement pst = con.prepareStatement(sql);
                    ResultSet rs = pst.executeQuery(sql);
                    while (rs.next()) {
                    %>
                     <div class="container">
    <div class="row">
      <div class="col-md-6 offset-md-3">
        <h2 class="text-center text-dark mt-5">Update Employee Detail Form</h2>
       
        <div class="card my-5">
                    
                    
                    <form action="update_employee_data.jsp" method="post" class="card-body cardbody-color p-lg-5">
            <div class="mb-3">
                <input type="text" name="name" class="form-control" value="<%=rs.getString(1)%>"  id="Username" autocomplete="off" aria-describedby="emailHelp"
                placeholder="User Name">
            </div>
                
            <div class="mb-3">
                <input type="textarea" id="id" class="form-control" value="<%=rs.getString(2)%>" placeholder="Address" name="add" rows="7" autocomplete="off" cols="10"></textarea>
                    
             </div>
            
            <div class="mb-3">
                <input type="number" class="form-control" value="<%=rs.getString(3)%>"  name="number" autocomplete="off" id="password" placeholder="Phone">
            </div>     
                
                <div class="mb-3">
                    <input type="email" name="email"  autocomplete="off" value="<%=rs.getString(4)%>" class="form-control" id="password" placeholder="Email">
            </div>                                         
                
            <div class="text-center"><button type="submit" class="btn btn-success" class="btn btn-color px-5 mb-5 w-100">Update Data</button></div>
            
          </form>
            
                 
        </div>

      </div>
    </div>
  </div>       
                    
                    
                    <%
                     
    }
con.close();
                

    }
catch (Exception e){
                    //JOptionPane.showMessageDialog(this, e);
                }

                    
               
             
                
                %>
           
 
            
            
            
        
    </body>
</html>
