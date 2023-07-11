 <html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    
    <style>
        
        .gradient-custom {
    /* fallback for old browsers */
    background: #6a11cb;
    
    /* Chrome 10-25, Safari 5.1-6 */
    background: -webkit-linear-gradient(to right, rgba(106, 17, 203, 1), rgba(37, 117, 252, 1));
    
    /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
    background: linear-gradient(to right, rgba(106, 17, 203, 1), rgba(37, 117, 252, 1))
    }
    
body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;   
    
  }
  #image{
/*  filter:blur(5px);
  -webkit-filter: blur(5px);*/
  background-size: 100%;
  position: fixed;
  filter: saturate(blu);
 

  }
    </style>
    <style>
        
        .gradient-custom {
    /* fallback for old browsers */
    background: #6a11cb;
    
    /* Chrome 10-25, Safari 5.1-6 */
    background: -webkit-linear-gradient(to right, rgba(106, 17, 203, 1), rgba(37, 117, 252, 1));
    
    /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
    background: linear-gradient(to right, rgba(106, 17, 203, 1), rgba(37, 117, 252, 1))
    }
    
body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;   
    
  }
  #image{
/*  filter:blur(5px);
  -webkit-filter: blur(5px);*/
  background-size: 100%;
  position: fixed;
  filter: saturate(blu);
  }
  .p-5 {
    padding: 1rem!important;
}

form *{
    font-family: 'Poppins',sans-serif;
    color: #ffffff;
    letter-spacing: 0.5px;
    outline: none;
    border: none;
}
form h3{
    font-size: 32px;
    font-weight: 500;
    line-height: 42px;
    text-align: center;
}

label{
    display: block;
    margin-top: 30px;
    font-size: 20px;
    font-weight: 500;
}
input{
    display: block;
    height: 50px;
    width: 100%;
   background-color: rgb(0 0 0 / 50%);
    border-radius: 3px;
    padding: 0 10px;
    margin-top: 8px;
    font-size: 20px;
    font-weight: 300;
}
::placeholder{
    color: #e5e5e5;
}
button{
    margin-top: 50px;
    width: 100%;
    background-color: #ffffff;
    color: #080710;
    padding: 15px 0;
    font-size: 18px;
    font-weight: 600;
    border-radius: 5px;
    cursor: pointer;
}
.social{
  margin-top: 30px;
  display: flex;
}
.social div{
  background: red;
  width: 150px;
  border-radius: 3px;
  padding: 5px 10px 10px 5px;
  background-color: rgba(255,255,255,0.27);
  color: #eaf0fb;
  text-align: center;
}
.social div:hover{
  background-color: rgba(255,255,255,0.47);
}
.social .fb{
  margin-left: 25px;
}
.social i{
  margin-right: 4px;
}

form{
    height: 365px;
    width: 500px;
    background-color: rgba(255,255,255,0.13);
    position: absolute;
    transform: translate(-50%,-50%);
    top: 50%;
    left: 50%;
    border-radius: 10px;
    backdrop-filter: blur(10px);
    border: 2px solid rgba(255,255,255,0.1);
    box-shadow: 0 0 40px rgba(8,7,16,0.6);
    padding: 50px 35px;
    margin-top: 0px;
}

.alert-warning {
    --bs-alert-color: #1fff48;
    --bs-alert-bg: #25b61c;
    --bs-alert-border-color: var(--bs-warning-border-subtle);
    --bs-alert-link-color: var(--bs-warning-text);
}
b, strong {
    font-weight: bolder;
    font-size: 19px;
}
.alert-dismissible {
    padding-right: 0rem;
    margin-top: -39px;
}
.alert-success {
    --bs-alert-color: var(--bs-success-text);
    --bs-alert-bg: #1fbc73;
    --bs-alert-border-color: var(--bs-success-border-subtle);
    --bs-alert-link-color: var(--bs-success-text);
}
    </style>
    
    <link rel="icon"  href="hotel-sign.png">
    <title>Verify OTP guest Sign up</title>
</head>
<body>
   
    
       
    <section class="vh-100" style=" background-size: 100%;
  position: fixed;
  position: fixed;
    top: 0;
    right: 0;
    left: 0;
     background-image: url(https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8aG90ZWx8ZW58MHx8MHx8&w=1000&q=80)">
        <form action="verifyotp_guest.jsp" method="post">
            <%
    String msg = String.valueOf(session.getAttribute("msg"));
    
%>

<div class="alert alert-success d-flex align-items-center" role="alert">
  <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
  <div>
  <%=msg%>
  </div>
</div>
    <%
      //  session.removeAttribute("msg");
    %>
       
                 <label for="username">Enter OTP</label>
        <input type="text" placeholder="Enter your OTP" autocomplete="off" name="username" id="username">
        <button>Submit OTP</button>
        
    </form>
      </section>
      
</body>
</html>