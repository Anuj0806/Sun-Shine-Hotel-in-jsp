<%-- 
    Document   : editemployee
    Created on : 18-Mar-2023, 8:13:36 pm
    Author     : Jitender
--%>

<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Employee</title>
        <link rel="icon"  href="hotel-sign.png">
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
.hide{
    animation-name: example;
  animation-duration: 4s;
}
  @font-face example{
      visibility: hidden;
  
}

        </style>
    </head>
   
    <body>
        <%!
             int lastid;
             public int getlastid(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
            String sql = "select max(employeeid) from employee";
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery(sql);
            if (rs.next()) {
                lastid = rs.getInt(1);
                lastid++;

            } else {

            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
return lastid;
    }
    
    
   
                     %>
                     
                     <%
                         
                         
        int len=10;
        String valid="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder st=new StringBuilder();
        Random rand=new Random();
        while(0<len--){
            st.append(valid.charAt(rand.nextInt(valid.length())));
        }
        



                         %>
     <div class="container">
    <div class="row">
      <div class="col-md-6 offset-md-3">
        <h2 class="text-center text-dark mt-5">Add New Employee Form</h2>
       
        <div class="card my-5">
             <%
        String msg=request.getParameter("msg");
        if("valid".equals(msg)){
        %>
        <center><font class="hide" color="red" size="5">Successfully Added</font></center>
            <%
                }
                %>

 <%
       
        if("invalid".equals(msg)){
        %>
<center><font color="red" size="5">Employee is Email Already Exist </font></center>
            <%
                }
                %>


<form action="addemployeedetail.jsp" method="post" class="card-body cardbody-color p-lg-5">

                <div class="mb-3">
                    <input type="text" name="id" class="form-control" id="Username" value="<%=getlastid()%>" autocomplete="off" aria-describedby="emailHelp"
                placeholder="Employee Id" readonly="readonly">
            </div>
           

            <div class="mb-3">
                <input type="text" name="name" pattern="[A-Z]{1}[a-z]{3,}" title="Name character must be greater than 3. First alphabat must be capital letter" class="form-control" id="Username" autocomplete="off" aria-describedby="emailHelp"
                       placeholder="User Name" required="">
            </div>
                
            <div class="mb-3">
                <input type="textarea" id="id" class="form-control" placeholder="Address" name="address" rows="7" autocomplete="off" cols="10" required=""></textarea>
                    
             </div>
            
            <div class="mb-3">
                <input type="tel"  pattern="[0-9]{3}[0-9]{3}[0-9]{4}" title="Phone no contain 10 Number" class="form-control" name="number" autocomplete="off" id="password" placeholder="Phone" required="">
            </div>     
                
                <div class="mb-3">
                    <input type="email" name="email" autocomplete="off" class="form-control" id="password" placeholder="Email" required="">
            </div>                                         
                
                 <div class="mb-3">
                     <input type="text" name="password" autocomplete="off" class="form-control" value="<% out.print(st);%>" id="password" placeholder="password" readonly="readonly">
            </div>   
            <div class="text-center"><button type="submit" class="btn btn-success" class="btn btn-color px-5 mb-5 w-100">Sava Employee Data</button></div>
            
          </form>
        </div>

      </div>
    </div>
  </div>
    </body>
</html>
