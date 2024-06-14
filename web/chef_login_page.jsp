<%@page contentType="text/html" pageEncoding="UTF-8"%>
   
<html>
    <head>
        <title>Sun Shine Hotel</title>
        <link rel="icon"  href="./image/hotel-sign.png">       
        <link rel="stylesheet" href="./css/home.css">    
        <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
        <style>
            body{
                display: flex;
                flex-direction: column;
            }
        </style>
    </head>    
    <body class="imagechef">    
        <%
       
        if (session.getAttribute("employee") == null && session.getAttribute("admin_email") == null) {
                response.sendRedirect("employeelogin.html");
            }
    %>
        
        <nav style="background: #2c94b3;margin-bottom: 0px;">
            <ul>
                <li class="logo">Sun Shine Hotel</li>                
                <li class="items"><a href="show_confirm_order.jsp">Confirm Oreders</a></li>
                <li class="items"><a href="show_pending_order.jsp">Show Pending Oreders</a></li>
                <li class="items"><a href="logout.jsp?employee=employee">Log Out</a> </li>
                <li class="btn"><i class="fas fa-bars"><a href="#"></a></i></li>
            </ul>
        </nav>
        <div  ></div>
        <footer>
            <p style="margin: 0px;">&copy; 2023 Sun Shine Hotels</p>
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
