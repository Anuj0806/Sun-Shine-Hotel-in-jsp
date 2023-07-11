
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Password Page</title>
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
        <h2 class="text-center text-dark mt-5">Enter OTP</h2>
       
        <div class="card my-5">
             <%
    String msg = String.valueOf(session.getAttribute("msg"));
    
%>

<div class="alert alert-success d-flex align-items-center" role="alert">
  <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
  <div>
  <%=msg%>
  </div>
</div>
    <%
       // session.removeAttribute("msg");
    %>


            <form action="update_guest_password.jsp" method="post" class="card-body cardbody-color p-lg-5">                                                                      
            <div class="mb-3">
                <input type="text" class="form-control" name="otp" autocomplete="off" id="password" placeholder="Enter OTP" required>
            </div>                     
                <div class="mb-3">
                    <input type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one  number and one uppercase and lowercase letter, and at least 8 or more characters" name="password" autocomplete="off" class="form-control" id="password" placeholder="Enter new Password" required>
            </div>   
                <div class="mb-3">
                    <input type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one  number and one uppercase and lowercase letter, and at least 8 or more characters" name="retypepassword" autocomplete="off" class="form-control" id="password" placeholder="Re-Enter new Password" required>
            </div>    
            <div class="text-center"><button type="submit" class="btn btn-success" class="btn btn-color px-5 mb-5 w-100">Change Password</button>            </div>            
          </form>
        </div>

      </div>
    </div>
  </div>
    </body>
</html>

