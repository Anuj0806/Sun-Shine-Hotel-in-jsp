<html>
    <head>        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Password</title>
        <link rel="icon"  href="hotel-sign.png">
        <link rel="stylesheet" href="./css/form.css">  
    </head>   
    <body>              
        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>            
                <li class="items">Change Password Employee</li>       

                <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
            </ul>
        </nav>
        <h2 style="
            text-align: center;
            ">Update Employee Password</h2>               
        <div class="cardcon">                               
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
        <footer>
            <p style="margin: 0px" >&copy; 2023 Sun Shine Hotels</p>
        </footer>
    </body>
</html>
