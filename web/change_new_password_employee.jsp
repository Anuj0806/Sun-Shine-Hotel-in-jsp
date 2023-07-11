
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Password</title>
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
        <h2 class="text-center text-dark mt-5">Update Employee Password</h2>
       
        <div class="card my-5">
            


            <form action="change_new_password.jsp" method="post" class="card-body cardbody-color p-lg-5">                                                                      
            <div class="mb-3">
                <input type="text" class="form-control" pattern="[A-Z]{1}[a-z]{3,}" title="Name character must be greater than 3. First alphabat must be capital letter" name="name" autocomplete="off" id="password" placeholder="Employee Name" required="">
            </div>                     
                <div class="mb-3">
                    <input type="email" name="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" title="Please enter a valid Email" autocomplete="off" class="form-control" id="password" placeholder="Email" required="">
            </div>     
                
            <div class="text-center"><button type="submit" class="btn btn-success" class="btn btn-color px-5 mb-5 w-100">Send OTP</button>            
            
            </div>            
          </form>
        </div>

      </div>
    </div>
  </div>
    </body>
</html>
