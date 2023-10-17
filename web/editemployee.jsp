<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/form.css">
        <title>JSP Page</title>
    </head>   
    <body>
        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>            
                <li class="items">Update Employee Details</li>                       
                <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
            </ul>
        </nav>              
        <%
            String id = request.getParameter("id");
            session.setAttribute("id", id);
            try {
                Class.forName(driver);
                Connection con = DriverManager.getConnection(url, user, password1);
                String sql = "select name,address,phone,email from employee where employeeid='" + id + "'";
                PreparedStatement pst = con.prepareStatement(sql);
                ResultSet rs = pst.executeQuery(sql);
                while (rs.next()) {
        %>
        <h2  style="
             text-align: center;
             ">Update Employee Detail Form</h2>
        <div class="cardcon mt-3">                            
            <form action="update_employee_data.jsp" method="post" class="card-body cardbody-color p-lg-5">
                <input type="text" hidden=""  name="id" value="<%=id%>" >
                <div class="mb-3">
                    <input type="text" name="name" class="form-control" value="<%=rs.getString(1)%>"  id="Username" autocomplete="off" aria-describedby="emailHelp"
                           placeholder="User Name">
                </div>                
                <div class="mb-3">
                    <input type="textarea" id="id" class="form-control" value="<%=rs.getString(2)%>" placeholder="Address" name="add" rows="7" autocomplete="off" cols="10"></textarea>                    
                </div>            
                <div class="mb-3">
                    <input type="number" class="form-control" value="<%=rs.getString(3)%>"  name="number" autocomplete="off" id="password" placeholder="Phone">
                </div>                     
                <div class="mb-3">
                    <input type="email" name="email"  autocomplete="off" value="<%=rs.getString(4)%>" class="form-control" id="password" placeholder="Email">
                </div>                                                         
                <div class="text-center"><button type="submit" class="btn btn-success" class="btn btn-color px-5 mb-5 w-100">Update Data</button></div>            
            </form>                             
        </div>  
    </div>                                               
    <%
            }
            con.close();
        } catch (Exception e) {
            out.print(e);
        }
    %>                                                        
</body>
</html>
