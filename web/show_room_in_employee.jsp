<%@include file="config.jsp" %>
<html lang="en">
    <head>
        <title>All Room Detail</title>
        <link rel="icon"  href="hotel-sign.png">    
        <link href="./css/tables.css" rel="stylesheet">           
    </head>
    <body>
        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>            
                <li class="items"><a>Room List</a></li>                       
                <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
            </ul>
        </nav>
        <div class="container">
            <table class="scrollit">
                <thead>
                    <tr>                            
                        <th class="text">Room No</th>
                        <th>Room Class</th>
                        <th>Number of Beds</th>				
                        <th>Floor</th>
                        <th>AC or Non AC Room </th>
                        <th>Price</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <%
                    try {
                        Class.forName(driver);
                        Connection con = DriverManager.getConnection(url, user, password1);
                        String sql = "select * from room";
                        PreparedStatement pst = con.prepareStatement(sql);
                        ResultSet rs = pst.executeQuery(sql);
                        while (rs.next()) {
                %>                                         
                <tr>                               
                    <td><%=rs.getString(1)%></td>
                    <td><%=rs.getString(2)%></td>
                    <td><%=rs.getString(3)%></td>
                    <td><%=rs.getString(4)%></td>
                    <td><%=rs.getString(5)%></td>
                    <td><%=rs.getString(6)%></td>
                    <td><a href="delete_room_in_employee.jsp?id=<%=rs.getString(1)%>">Delete</a></td>
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