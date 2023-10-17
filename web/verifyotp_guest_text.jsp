<html lang="en">
    <head>      
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <link rel="stylesheet" href="./css/form.css">      
        <link rel="icon"  href="hotel-sign.png">
        <title>Verify OTP guest Sign up</title>
    </head>
    <body>
        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>            
                <li class="items">Enter OTP </li>       

                <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
            </ul>
        </nav>
        <h2 style="text-align: center;">Verify OTP</h2>
        <div class="cardcon">      
            <form action="verifyotp_guest.jsp" method="post">
                <label for="username">Enter OTP</label>
                <input type="text" placeholder="Enter your OTP" autocomplete="off" name="username" id="username">
                <button>Submit OTP</button>
            </form>
        </div>
    </body>
</html>