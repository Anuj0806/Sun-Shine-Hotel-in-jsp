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
        <title>Add New Room</title>
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
       
                     
                   
     <div class="container">
    <div class="row">
      <div class="col-md-6 offset-md-3">
        <h2 class="text-center text-dark mt-5">Add New Room Form</h2>
       
        <div class="card my-5">
            

            <form action="add_room_emaploye_codeing.jsp" method="post" class="card-body cardbody-color p-lg-5">

               
           

            <div class="mb-3">
                <input type="number" name="room_no" class="form-control" id="Username" autocomplete="off" aria-describedby="emailHelp"
                       placeholder="Room Number" required="">
            </div>
           
                <div class="mb-3">
                    <input type="text" name="Room_Class" class="form-control" id="Username" autocomplete="off" aria-describedby="emailHelp"
                       placeholder="Room Class" required="">
            </div>
            
                 <div class="mb-3">
                    <input type="text" name="Room_Beds" class="form-control" id="Username" autocomplete="off" aria-describedby="emailHelp"
                       placeholder="Room_Beds" required="">
                 </div>
                 
                  <div class="mb-3">
                    <input type="text" name="floor" class="form-control" id="Username" autocomplete="off" aria-describedby="emailHelp"
                       placeholder="Floor" required="">
                  </div>
                
                <div class="mb-3">
                    <input type="text" name="type" class="form-control" id="Username" autocomplete="off" aria-describedby="emailHelp"
                       placeholder="Room type AC or NON AC" required="">
                  </div>
                
                
                <div class="mb-3">
                    <input type="number" name="price" autocomplete="off" class="form-control" id="password" placeholder="Price of Room" required="">
            </div>                                         
                
                 
            <div class="text-center"><button type="submit" class="btn btn-success" class="btn btn-color px-5 mb-5 w-100">Add Room</button></div>
            
          </form>
        </div>

      </div>
    </div>
  </div>
    </body>
</html>
