<html>
    <head>       
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot Password</title>
        <link rel="icon"  href="hotel-sign.png">
        <link rel="stylesheet" href="./css/form.css">       
    </head>
    <body>
        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>            
                <li class="items">Change Password </li>       
                <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
            </ul>
        </nav>   
        <h2>Forgot Guest Password</h2>
        <div class="cardcon">                      
            <form action="forgot_password_guest_1.jsp" class="card-body cardbody-color p-lg-5">                                                                      
                <div class="mb-3">
                    <input type="text" class="form-control" name="name" pattern="[A-Z]{1}[a-z ]{3,}" title="Name character must be greater than 3. First alphabat must be capital letter" autocomplete="off" id="password" placeholder="Enter Your Name" required="">
                </div>                     
                <div class="mb-3">
                    <input type="email" name="email" autocomplete="off" class="form-control" id="password" placeholder="Email" required="">
                </div>     
                <div class="text-center"><button type="submit" class="btn btn-success" class="btn btn-color px-5 mb-5 w-100">Send OTP</button>            </div>            
            </form>
        </div>
    </body>
</html>
