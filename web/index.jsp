<%@include file="config.jsp" %>
<html lang="en">
    <head>
        <title>Sun Shine Hotel</title>
        <link rel="icon"  href="hotel-sign.png">        
        <link href="./css/bootstrap.css" rel="stylesheet">   
        <link rel="stylesheet" href="./css/home.css">
        <script>
            function myFunction() {
                alert("Your record is added. We will contact you Soon");
            }
            function welcome(){
                alert("First Login with your valid Details");
            }
        </script>
    </head>    
    <body style="    margin-top:  6%;">        
        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>
                <li class="items"><a href="guest_login_signup_page.html">Guest Login</a></li>
                <li class="items"><a href="employeelogin.html">Employee Login</a></li>
                <li class="items"><a href="admin.html">Admin Login</a></li>
                <li class="items"><a href="#contact">Contact</a></li>
                <li class="items"><a href="#aboutSection">About Us</a></li>
                <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
            </ul>
        </nav>
        <%   try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(url, user, password1);
                PreparedStatement ps = con.prepareStatement("select * from room order by room_no asc");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>       

        <div class="card" style="width: 18rem;">                              
            <img class="card-img-top" src="imageServlet?id=<%=rs.getString("room_no")%>" height="150" width="200" alt="Card image cap">
            <div class="card-body">
                <h5 class="card-title">Room No.&nbsp;<%=rs.getString("room_no")%></h5>
                <p class="card-text"><%=rs.getString("Description")%></p>
                <a href="guest_login_signup_page.html" onclick="welcome()" class="btn btn-primary">Book Room</a>
            </div>
        </div>
        <%
                }
                con.close();
                rs.close();
                ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        <div  id="aboutSection" class="container">
            <h1>About Us</h1>
            <p>We are a hotel management company that specializes in managing luxury hotels and resorts. Our team is composed of experienced professionals who are dedicated to providing the highest level of service to our clients.</p>
            <p>Our goal is to help hotel owners and operators maximize the potential of their properties, and we achieve this by focusing on operational efficiency, revenue optimization, and guest satisfaction.</p>
            <p>At Hotel Management, we understand that each property is unique, and we tailor our services to meet the specific needs of each client. Whether you are looking for full-service management or individual services, we have the expertise and resources to help you succeed.</p>
        </div>
        <div  class="container" id="contact">
            <h1>Contact Us</h1>
            <form onsubmit="myFunction()" >
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" placeholder="Your name" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="Your email" required>

                <label for="subject">Subject:</label>
                <input type="text" id="subject" name="subject" placeholder="Subject" required>

                <label for="message">Message:</label>
                <textarea id="message" name="message" rows="1" placeholder="Your message" required></textarea>
                <input type="submit"></button>
            </form>
        </div>                      
        <footer style="position: relative;top: 0px" >
            <p style="margin-bottom: 0px;">&copy; 2023 Sun Shine Hotels</p>
        </footer>


        <script>
            $(document).ready(function () {
                $('.btn').click(function () {
                    $('.items').toggleClass("show");
                    $('ul li').toggleClass("hide");
                });
            });
        </script>
    </body>
</html>
