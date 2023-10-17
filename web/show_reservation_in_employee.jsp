<%@include file="config.jsp" %>
<html lang="en">
    <head>
        <title>Reservation</title>
        <link rel="icon"  href="hotel-sign.png">       
        <link rel="stylesheet" href="./css/tables.css"> 
    </head>
    <body>
        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>            
                <li class="items">Reserved Rooms</li>       
                <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
            </ul>
        </nav>
        <div class="container">
            <table class="scrolldown" >
                <thead>
                    <tr>                            
                        <th class="text">Room No</th>
                        <th>Check In Detail</th>
                        <th>Check Out Detail</th>								
                        <th>Check Out</th>
                    </tr>
                </thead>
                <%
                    try {
                        Class.forName(driver);
                        Connection con = DriverManager.getConnection(url, user, password1);
                        String sql = "select * from reservation";
                        PreparedStatement pst = con.prepareStatement(sql);
                        ResultSet rs = pst.executeQuery(sql);
                        while (rs.next()) {
                %>
                <tr>                               
                    <td><%=rs.getString(1)%></td>
                    <td><%=rs.getString(2)%></td>
                    <td><%=rs.getString(3)%></td>
                    <td><a href="check_out.jsp?id=<%=rs.getString(1)%>">To Check Out click</a></td>
                </tr>                   
                <%
                        }
                        con.close();
                    } catch (Exception e) {
                        out.print(e);
                    }
                %>
            </table>
        </div>
        <footer>
            <p style="margin: 0px" >&copy; 2023 Sun Shine Hotels</p>
        </footer>
    </body>
</html>