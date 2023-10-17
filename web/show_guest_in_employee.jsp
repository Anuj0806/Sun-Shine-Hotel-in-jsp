
<%@include file="config.jsp" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Design by foolishdeveloper.com -->
        <title>Guest Detail</title>
        <link rel="icon"  href="hotel-sign.png">
        <link rel="stylesheet" href="./css/tables.css">         
    </head>
    <body>
        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>            
                <li class="items">All Room Details</li>       

                <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
            </ul>
        </nav>
        <div class="container">
            <table >
                <thead>
                    <tr>                            
                        <th class="text">Name</th>
                        <th>Phone</th>
                        <th>Address</th>				
                        <th>Email</th>
                        <th>Password</th>

                        <th>Delete</th>
                    </tr>
                </thead>
                <%
                    try {
                        Class.forName(driver);
                        Connection con = DriverManager.getConnection(url, user, password1);
                        String sql = "select * from guest";
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
                    <td><a href="delete_guest_in_employee.jsp?id=<%=rs.getString(4)%>">Delete</a></td>
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