<html>
    <head>        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Room</title>
        <link rel="icon"  href="hotel-sign.png">
        <link rel="stylesheet" href="./css/form.css">  
    </head>   
    <body>    
        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>            
                <li class="items">Add New Room</li>       
                <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
            </ul>
        </nav>
        <h2 style="text-align: center;">Add New Room Form</h2>
        <div class="cardcon">          
            <span id="fadeout" class="error">${error}</span>            
            <form action="NewServlet" method="post" class="card-body cardbody-color p-lg-5" enctype="multipart/form-data">
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
                <div class="mb-3">
                    <textarea id="message" class="form-control" name="message" cols="58" placeholder="Your message" required></textarea>
                </div>  
                <div class="mb-3">
                    <input type="file" name="photo" autocomplete="off" class="form-control" id="password" placeholder="Price of Room" required="">
                </div>                                   
                <div class="text-center"><button type="submit" class="btn btn-success" class="btn btn-color px-5 mb-5 w-100">Add Room</button></div>
            </form>
        </div>
        <footer>
            <p style="margin: 0px" >&copy; 2023 Sun Shine Hotels</p>
        </footer>
    </body>
</html>
