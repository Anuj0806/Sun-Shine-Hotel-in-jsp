<html>
    <head>
        <title>Create New Password Page</title>
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
        <h2>Enter OTP</h2>
        <div class="cardcon"> 
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
        <footer>
            <p style="margin: 0px" >&copy; 2023 Sun Shine Hotels</p>
        </footer>
    </body>
</html>

