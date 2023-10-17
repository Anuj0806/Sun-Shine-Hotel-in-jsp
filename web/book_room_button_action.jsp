<%@include file="config.jsp" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Page</title>
        <link rel="icon"  href="hotel-sign.png">
        <link rel="stylesheet" href="./css/payment.css">
        <script src="./script/common.js" type="text/javascript"></script>     
    </head>
    <body>
        <%
            String room_no = request.getParameter("id");
            session.setAttribute("room_no", room_no);
            String prize = "";
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(url, user, password1);
                PreparedStatement ps = con.prepareStatement("select * from room where room_no='" + room_no + "'");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    prize = rs.getString("prize");
                }
                con.close();
                rs.close();
                ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            String date = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
        %>
        <input type="text" hidden="" id="price" value="<%=prize%>" >        
        <div class="mainscreen">          
            <div class="card">
                <div class="leftside">
                    <img src="https://i.pinimg.com/originals/18/9d/dc/189ddc1221d9c1c779dda4ad37a35fa1.png" class="product" alt="Shoes"/>
                </div>
                <div class="rightside">
                    <form class="form" method="post" action="payment_button_action.jsp" role="form" autocomplete="off">
                        <h1 style="margin: 0px;text-align: center">Payment</h1>
                        <div class="expcvv">
                            <p class="expcvv_text"  style="cursor: default">Check In</p>
                            <input type="date" class="inputbox" value="<%=date%>" readonly="" id="cc_name" name="checkin" id="exp_date" required />
                            <p class="expcvv_text2">Check Out</p>
                            <input type="date" class="inputbox" onchange="dateDiff()" id="cc1_name" name="checkout" id="exp_date" required />
                        </div>
                        <p>Cardholder Name</p>
                        <input type="text" class="inputbox" name="holder_name" required />
                        <p>Card Number</p>
                        <input type="text" class="inputbox" maxlength="16" pattern="\d{16}" title="Credit card number" max="16" minlength="15" name="number" id="card_number" required />

                        <p>Card Type</p>
                        <select class="inputbox"  id="card_type" required>
                            <option value="">--Select a Card Type--</option>
                            <option value="Visa">Visa</option>
                            <option value="RuPay">RuPay</option>
                            <option value="MasterCard">MasterCard</option>
                        </select>
                        <div class="expcvv">
                            <p class="expcvv_text">Expiry</p>
                            <input type="date" class="inputbox" name="cc_exp_mo" id="exp_date" required />
                            <p class="expcvv_text2">CVV</p>
                            <input type="password" class="inputbox" pattern="\d{3}" title="Three digits at back of your card" name="cvv" id="cvv" required />
                        </div>
                        <p></p>
                        <div class="expcvv">
                            <p class="expcvv_text">Price</p>
                            <input type="text" readonly="" id="exampleInputAmount" name="price"  class="inputbox" id="exp_date" required />                         
                        </div>                         
                        <button type="submit" class="button">CheckOut</button>
                    </form>
                </div>
            </div>
        </div>
        <footer>
            <p style="margin: 0px" >&copy; 2023 Sun Shine Hotels</p>
        </footer>
    </body>
</html>
