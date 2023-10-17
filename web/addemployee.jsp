<%@include file="config.jsp" %>
<html>
    <head>        
        <title>Add New Employee</title>
        <link rel="icon"  href="hotel-sign.png">
        <link rel="stylesheet" href="./css/form.css">
    </head>
    <body>
        <%!            int lastid;
            public int getlastid() {
                try {
                    Class.forName(driver);
                    Connection con = DriverManager.getConnection(url, user, password1);
                    String sql = "select max(employeeid) from employee";
                    PreparedStatement pst = con.prepareStatement(sql);
                    ResultSet rs = pst.executeQuery(sql);
                    if (rs.next()) {
                        lastid = rs.getInt(1);
                        lastid++;
                    } else {
                    }
                } catch (Exception e) {
                }
                return lastid;
            }
        %>

        <%
            int len = 10;
            String valid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            StringBuilder st = new StringBuilder();
            Random rand = new Random();
            while (0 < len--) {
                st.append(valid.charAt(rand.nextInt(valid.length())));
            }
        %>
        <nav>
            <ul>
                <li class="logo">Sun Shine Hotel</li>            
                <li class="items">Add New Employee</li>       
                <li class="btn"><a href="#"><i class="fas fa-bars"></i></a></li>
            </ul>
        </nav>
        <h2>Add New Employee Form</h2>
        <div class="cardcon mt-3">
            <form action="addemployeedetail.jsp" method="post">
                <div class="mb-3 pt-3">
                    <input type="text" name="id" class="form-control " id="Username" value="<%=getlastid()%>" autocomplete="off" aria-describedby="emailHelp"
                           placeholder="Employee Id" readonly="readonly">
                </div>
                <div class="mb-3">
                    <input type="text" name="name" pattern="[A-Z]{1}[a-z]{3,}" title="Name character must be greater than 3. First alphabat must be capital letter" class="form-control" id="Username" autocomplete="off" aria-describedby="emailHelp"
                           placeholder="User Name" required="">
                </div>
                <div class="mb-3">
                    <input type="textarea" id="id" class="form-control" placeholder="Address" name="address" rows="7" autocomplete="off" cols="10" required=""/>
                </div>
                <div class="mb-3">
                    <input type="tel"  pattern="[0-9]{3}[0-9]{3}[0-9]{4}" title="Phone no contain 10 Number" class="form-control" name="number" autocomplete="off" id="password" placeholder="Phone" required="">
                </div>     
                <div class="mb-3">
                    <input type="email" name="email" autocomplete="off" class="form-control" id="password" placeholder="Email" required="">
                </div>                                         
                <div class="mb-3">
                    <input type="text" name="password" autocomplete="off" class="form-control" value="<% out.print(st);%>" id="password" placeholder="password" readonly="readonly">
                </div>   
                <div class="text-center"><button type="submit"  >Sava Employee Data</button></div>
            </form>
        </div>
    </body>
    <footer>        
        <p style="margin: 0px;">&copy; 2023 Sun Shine Hotels</p>
    </footer>
</html>
