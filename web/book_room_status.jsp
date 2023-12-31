<%@include file="config.jsp" %>
<html lang="en">
    <head>    
        <title>Check Room Status</title>
        <link rel="icon"  href="hotel-sign.png">      
        <link rel="stylesheet" href="./css/tables.css">
    </head>
    <body>
        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>            
                <li class="items">Room Status</li>                       
                <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
            </ul>
        </nav>       
        <div class="container">
            <table >
                <thead>
                    <tr>
                        <th class="text">Email</th>
                        <th>Room no</th>
                        <th>Room Class</th>
                        <th>Number of Beds</th>				
                        <th>Floor</th>
                        <th>AC or Non AC Room </th>
                        <th>Price</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <%
                    String email = String.valueOf(session.getAttribute("email"));
                    try {
                        Class.forName(driver);
                        Connection con = DriverManager.getConnection(url, user, password1);
                        String sql = "select * from status where email='" + email + "'";
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
                    <td><%=rs.getString(8)%></td>
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