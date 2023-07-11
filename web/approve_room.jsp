<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Design by foolishdeveloper.com -->
        <title>Approve Room</title>
        <link rel="icon"  href="hotel-sign.png"><!-- comment -->        
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">


        <style>
            html,
            body {
                height: 100%;
            }

            body {
                margin: 0;
                background: linear-gradient(45deg, #49a09d, #5f2c82);
                font-family: sans-serif;
                font-weight: 100;
            }


            .container {
                position: fixed;
                top: 1%;
                left: 1%;
                transform: translate(-50%, -50%);
                overflow: scroll;
                height: 500px;
                width: 1355px;
                margin-left: 583px;
                margin-top: 295px;
            }

            table th {
                position: -webkit-sticky;
                position: sticky;
                top: 0;
                z-index: 1;
                background: blue;
                padding: 7px;
            }


            table {
                position: fixed;
                width: 100%;
                border-collapse: collapse;


                box-shadow: 0 0 20px rgba(0,0,0,0.1);
            }

            th,
            td {
                margin: 12px;
                padding: 20px;
                background-color: rgba(255,255,255,0.2);
                color: #fff;
            }
            table, th, td {
                border: 1px solid;
                margin-left: 3px;
            }

            th {
                text-align: left;

            }
            th text{
                text-align: left;
                margin-right: 10px;
            }
            thead {
                th {
                    background-color: #55608f;
                }
            }

            tbody {
                tr {
                    &:hover {
                        background-color: rgba(255,255,255,0.3);
                    }
                }
                td {
                    position: relative;
                    &:hover {
                        &:before {
                            content: "";
                            position: absolute;
                            left: 0;
                            right: 0;
                            top: -9999px;
                            bottom: -9999px;
                            background-color: rgba(255,255,255,0.2);
                            z-index: -1;
                        }
                    }
                }
            }

        </style>

    </head>
    <body>        
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
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
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
                    <td><%=rs.getString(8)%></td>
                    <td><%=rs.getString(9)%></td>
                    <td><a href="approve_room_button_action.jsp?email=<%=rs.getString(1)%>&room=<%=rs.getString(2)%>&class=<%=rs.getString(3)%>&bed=<%=rs.getString(4)%>&floor=<%=rs.getString(5)%>&ac=<%=rs.getString(6)%>&price=<%=rs.getString(7)%>&checkin=<%=rs.getString(8)%>&checkout=<%=rs.getString(9)%>">Approve Room</a></td>
                    <td><a href="disapprovee_room_button_action.jsp?email=<%=rs.getString(1)%>&room=<%=rs.getString(2)%>&class=<%=rs.getString(3)%>&bed=<%=rs.getString(4)%>&floor=<%=rs.getString(5)%>&ac=<%=rs.getString(6)%>&price=<%=rs.getString(7)%>&checkin=<%=rs.getString(8)%>&checkout=<%=rs.getString(9)%>">Disapprove Room</a></td>                                   
                </tr>                          
                <%
                        }
                        con.close();

                    } catch (Exception e) {
                        //JOptionPane.showMessageDialog(this, e);
                    }

//hbjnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
  

                %>






            </table>
        </div>


    </body>
</html>