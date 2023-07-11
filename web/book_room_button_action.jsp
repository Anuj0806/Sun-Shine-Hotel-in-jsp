<%-- 
    Document   : book_room _button_action
    Created on : 25-Mar-2023, 10:57:15 am
    Author     : Jitender
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Page</title>
        <link rel="icon"  href="hotel-sign.png">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>
    body{
         background-size: 100%;
          position: absolute;
            
          top: 0px;
          right: 0px;
          left: 0;
}
   form {
    height: 520px;
    width: 453px;
    background-color: rgba(255,255,255,0.13);
    position: absolute;
    transform: translate(-50%,-50%);
    top: 0%;
    left: 50%;
    border-radius: 10px;
    backdrop-filter: blur(10px);
    border: 2px solid rgba(255,255,255,0.1);
    box-shadow: 0 0 40px rgb(45 27 186 / 60%);
    padding: 30px 35px;
    margin-top: 324px;
}
.h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
    margin-bottom: -1.5rem;
    font-family: inherit;
    font-weight: 500;
    line-height: 1.2;
    color: inherit;
    margin-top: -36px;
}
div .card-outline-secondary {
    height: 16px;
    width: 459px;
    background-color: rgba(255,255,255,0.13);
    position: absolute;
    transform: translate(-50%,-50%);
    top: 20971%;
    left: 45%;
    border-radius: 10px;
    backdrop-filter: blur(10p);
    border: 2px solid rgba(255,255,255,0.1);
    box-shadow: 0 0 40px rgba(8,7,16,0.6);
    padding: 27px 35px;
    margin-top: -172px;
}
label {
    display: inline-block;
    margin-bottom: 0.5rem;
    color: black;
    font-size: 23px;
}
h3.text-ce{
    margin-left:510px;
    font-size: 17px;
    text-align: center;
}

</style> 
<script>
    function dateDiff() {
try {
    var anuj=<%=request.getParameter("price")%>;
    var d1 = document.getElementById("cc_name").value;
var d2 = document.getElementById("cc1_name").value;    
 //var prize = document.getElementById("date").value;
const dateOne = new Date(d1);
const dateTwo = new Date(d2);
const time = Math.abs(dateTwo - dateOne);
var days = Math.ceil(time / (1000 * 60 * 60 * 24));
// document.write(days);
var pr=days*anuj;

document.getElementById("exampleInputAmount").value = pr;
//alert(days);

}
catch(ex) {
    alert(ex);
}
        }
    
    
    
</script>        
    </head>
    <body background="https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8aG90ZWx8ZW58MHx8MHx8&w=1000&q=80)">
        
<!------ Include the above in your HEAD tag ---------->
<%
 String room_no=request.getParameter("id"); 
 String price=request.getParameter("price");    
 String clas=request.getParameter("class");    
 String bed=request.getParameter("bed");    
 String floor=request.getParameter("floor");    
 String ac=request.getParameter("ac");
 session.setAttribute("room_no", room_no);
 session.setAttribute("price", price);
session.setAttribute("class", clas);
session.setAttribute("bed", bed);
session.setAttribute("floor", floor);
session.setAttribute("ac", ac);
%>
   <div class="col-md-6 offset-md-3">
                    <span class="anchor" id="formPayment"></span>
                    <hr class="my-5">
 
                    <!-- form card cc payment -->
                    <div class="card card-outline-secondary">
                        
                        
                       
                        <div class="card-body">
                            <h3 class="text-center">Room Payment</h3> 
                            
                              
                            
                            
                            <form class="form" method="post" action="payment_button_action.jsp" role="form" autocomplete="off">
                                <div class="form-group">
                                    <label for="cc_name">Check In Date</label>
                                    <input type="date" class="form-control" name="checkin" id="cc_name" placeholder="Check In Date" required="required">
                                </div>
                                <div class="form-group">
                                    <label for="cc_name">Check Out Date</label>
                                    <input type="date" class="form-control" onfocusout="dateDiff()" name="checkout" id="cc1_name" required="required">
                                </div>
                                <div class="form-group">                                    
                                    <input type="text" class="form-control" id="cc_name" pattern="[A-Z]{1}[a-z]{3,}" title="Name character must be greater than 3. First alphabat must be capital letter" placeholder="Card Holder's Name" name="holder_name" required="required">
                                </div>
                                <div class="form-group">
                                   
                                    <input type="text" class="form-control" autocomplete="off" maxlength="20" pattern="\d{16}" placeholder="Card Number" name="number" title="Credit card number" required="">
                                </div>
                                <div class="form-group row">
                                   
                                    <div class="col-md-4">
                                        <select class="form-control"  name="cc_exp_mo" size="0">
                                            <option value="01">01</option>
                                            <option value="02">02</option>
                                            <option value="03">03</option>
                                            <option value="04">04</option>
                                            <option value="05">05</option>
                                            <option value="06">06</option>
                                            <option value="07">07</option>
                                            <option value="08">08</option>
                                            <option value="09">09</option>
                                            <option value="10">10</option>
                                            <option value="11">11</option>
                                            <option value="12">12</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <select class="form-control" name="cc_exp_yr" size="0">
                                            <option>2024</option>
                                            <option>2025</option>
                                            <option>2026</option>
                                            <option>2027</option>
                                            <option>2028</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <input type="text" class="form-control" autocomplete="off" maxlength="3" pattern="\d{3}" title="Three digits at back of your card" required="" name="cvv" placeholder="CVV">
                                    </div>
                                </div>
                                <div class="row">
                                   
                                </div>
                                <div class="form-inline">
                                    <div class="input-group">
                                        <div class="input-group-prepend"><span class="input-group-text">Rs</span></div>
                                        <input type="text" class="form-control text-right" id="exampleInputAmount" name="price" readonly  placeholder="Price" ">
                                        <div class="input-group-append"><span class="input-group-text">.00</span></div>
                                    </div>
                                </div>
                                <hr>
                                <div class="form-group row">
                                    <div class="col-md-6">
                                        <button type="reset" class="btn btn-success btn-lg btn-block">Reset</button>
                                    </div>
                                    <div class="col-md-6">
                                        <button type="submit" class="btn btn-success btn-lg btn-block">Submit</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- /form card cc payment -->
                
              
        
        
        
        <%
            
            %>
    </body>
</html>
