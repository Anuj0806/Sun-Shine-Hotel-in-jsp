<%@include file="config.jsp" %>
<html lang="en">
    <head>
        <title>Book New Room</title>
        <link rel="icon"  href="hotel-sign.png">    
         <link href="./css/bootstrap.css" rel="stylesheet">   
        <link rel="stylesheet" href="./css/home.css">   
    </head>    
    <body>        
        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>            
                <li class="items"><a href="book_room_status.jsp">Book Room Status</a></li>       
                 <li class="items"><a href="index.jsp">Log Out</a></li>  
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
            <img class="card-img-top" src="imageServlet?id=<%=rs.getString("room_no")%>" height="100" width="200" alt="Card image cap">
            <div class="card-body">
                <h5 class="card-title">Room No.&nbsp;&nbsp;  <%=rs.getString("room_no")%></h5>
                <p class="card-text"><%=rs.getString("Description")%></p>
                <a href="book_room_button_action.jsp?id=<%=rs.getString("room_no")%>" class="btn btn-primary">Book Room</a>
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
