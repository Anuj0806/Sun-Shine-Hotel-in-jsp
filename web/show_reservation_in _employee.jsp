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
    <title>Reservation</title>
 <link rel="icon"  href="hotel-sign.png">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
    
     <style>
       .topnav {
    padding: 17px;
    overflow: hidden;
    background-color: rgb(50, 50, 146);
    padding-right: 30px;
  }
  
  .topnav a {
    float: left;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
    font-size: 30px;
    font-family:Georgia, 'Times New Roman', Times, serif;
    /* padding-right: 30px; */
    
  }
  .topnav div.admin a{
  
 
  font-family:Georgia, 'Times New Roman', Times, serif;
  font-size: 22px;
   
  }
  .topnav div a.admin1{
    margin-left: 50%;
    margin-right: auto;
    margin-top: auto;
  }
  
  
  .topnav a:hover {
    background-color: #1113bb;
    color: black;
    border-radius: 78px;

  }
  .topnav a.active:hover{
    color:black;
  }
  .topnav a.raj{
    padding-right: 60px;
    font-size: 40px;
  }
  .topnav a.active {
    /* background-color: #04AA6D; */
    color: white;
    border-radius: 78px;
    padding-right: 30px;
    }
    .active{
      margin-left: px;
    }


     </style>
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
	top: 16%;
	left: 12%;
	transform: translate(-50%, -50%);
        overflow:scroll;
height:500px;
width:810px;
margin-left: 500px;
margin-top: 250px;
}

table {
    position: fixed; 
	width: 800px;
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
    <div class="topnav">
        <a >Sun Shine Hotel</a>
               <div class="admin">
            
            <a class="admin1" >All Reserved Room is Here</a>  
           
        </div>
    </div>
    
    <%
        String msg=request.getParameter("msg");
        if("valid".equals(msg)){
        %>
<center><font color="red" size="5">Successfully Updated</font></center>
            <%
                }
                %>

<%
       
        if("invalid".equals(msg)){
        %>
<center><font color="red" size="5">Something went wrong! Try again</font></center>
            <%
                }
                %>


<%
       
        if("deleted".equals(msg)){
        %>
<center><font color="red" size="5">Successfully Deleted</font></center>
            <%
                }
                %>




   <div class="container">
	<table >
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
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_management", "root", "Anuj0806$");
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
                
}
catch (Exception e) {
                    //JOptionPane.showMessageDialog(this, e);
                }
%>



                
                
		
	</table>
</div>
    
   
</body>
</html>