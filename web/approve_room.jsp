<%@include file="config.jsp" %>
<html lang="en">
    <head>
        <title>Approve Room</title>
        <link rel="icon"  href="hotel-sign.png">             
        <link rel="stylesheet" href="./css/tables.css">
    </head>
    <body>      
        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>            
                <li class="items">Room Approve Here</li>       
                <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
            </ul>
        </nav>
        <div class="container">
            <table >
                <thead>
                    <tr>                            
                        <th class="text">Email</th>
                        <th>Room No</th>
                        <th>Room Class</th>
                        <th>Number of Beds</th>				
                        <th>Floor</th>
                        <th>AC or Non AC Room </th>
                        <th>Price</th>
                        <th>Check In</th>
                        <th>Check Out</th>
                        <th>Approve Room</th>
                        <th>Disapprove Room</th>
                    </tr>
                    <%
                        try {
                            Class.forName(driver);
                            Connection con = DriverManager.getConnection(url, user, password1);
                            String sql = "select * from duplicateroom";
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
                        <td><%=rs.getString(7)%></td>
                        <td><%=rs.getString(10)%></td>
                        <td><%=rs.getString(11)%></td>
                        <td><a href="approve_room_button_action.jsp?room=<%=rs.getString(2)%>">Approve Room</a></td>
                        <td><a href="disapprovee_room_button_action.jsp?room=<%=rs.getString(2)%>">Disapprove Room</a></td>                                   
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