<%@include file="config.jsp" %>
<html lang="en">
    <head>
        <title>All Payment Page</title>
        <link rel="icon"  href="hotel-sign.png">
        <link rel="stylesheet" href="./css/tables.css">  
    </head>
    <body>       
        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>            
                <li class="items">Payment Details</li>       

                <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
            </ul>
        </nav>
        <div class="container">
            <table >
                <thead>
                    <tr>                            
                        <th class="text">Email</th>
                        <th>Card No</th>                       
                        <th>CVV</th>				
                        <th>Month</th>
                        <th>Year </th>
                        <th>Card holder name</th>
                        <th>Status</th>                                           
                    </tr>
                </thead>
                <%
                    try {
                        Class.forName(driver);
                        Connection con = DriverManager.getConnection(url, user, password1);
                        String sql = "select * from payment";
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