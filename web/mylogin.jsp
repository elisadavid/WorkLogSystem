<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.errorvalidate"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>WorkLog System - Login</title>
        <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    </head>
    <body>
        <%
            List<errorvalidate> arrError = (List<errorvalidate>) request.getAttribute("arrError");
            String msg = (String) request.getAttribute("msg");
        %>
        <div class="container">
            <div class="left-panel">
                <div class="overlay"></div>
                <div class="left-content">
                    <div class="logo-icon"><i class="fas fa-rocket"></i></div>
                    <h1> WORKLOG <br> <span>SYSTEM</span></h1>
                    <div class="line"></div>
                    <p>Track your work.<br>Meet your goals.<br><span>Achieve Excellence.</span></p>
                    <div class="feature-panel">
                        <div class="feature-box"><i class="fas fa-check"></i><h4>Log Tasks</h4></div>
                        <div class="feature-box"><i class="fas fa-clock"></i><h4>Track Time</h4></div>
                        <div class="feature-box"><i class="fas fa-chart-line"></i><h4>View Progress</h4></div>
                    </div>
                </div>
            </div>
            <div class="right-panel">
                <div class="curve"></div>
                <div class="login-card">
                    <div class="user-circle"><img src="img/isrologo.png" alt="ISRO Logo" width="90" height="90"></div>
                    <h2>Welcome Back</h2>
                    <p class="subtitle"> Sign in to continue to WorkLog System </p>
                    <% if (msg != null) {%>
                    <div class="server-error"> <%=msg%> </div>
                    <% }%>
                    <form id="loginForm" action="loginController" method="post" novalidate>
                        <input type="hidden"
                               name="actionType"
                               value="dashboard">
                        <label for="username">Username</label>
                        <div class="input-box">
                            <input type="text" id="username" name="username" maxlength="20" autocomplete="username" placeholder="Enter Username" value="<%=request.getParameter("username") != null ? request.getParameter("username") : ""%>">
                            <i class="fas fa-user"></i>
                        </div>
                        <span id="usernameError" class="field-error"></span>
                        <label for="password">Password</label>
                        <div class="input-box">
                            <input type="password" id="password" name="password" maxlength="30" autocomplete="current-password" placeholder="Enter Password">
                            <i id="eye" class="fas fa-eye"></i>
                        </div>
                        <span id="passwordError" class="field-error"></span>
                        <button type="submit"> Sign In <i class="fas fa-arrow-right"></i> </button>
                        <div class="action-links">
                            <a href="Welcome.jsp" class="btn-back"><i class="fas fa-home"></i> Home</a>
                            <a href="officerController?actionType=openRegistration" class="btn-back"><i class="fas fa-user-plus"></i> Register</a>
                        </div>
                        <div class="footer">
                            <i class="fas fa-shield-alt"></i> Secure &nbsp;&nbsp; Reliable &nbsp;&nbsp; Efficient
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <style>
            *{
                margin:0;
                padding:0;
                box-sizing:border-box;
                font-family:"Segoe UI",sans-serif;
            }
            body{
                width:100%;
                min-height:100vh;
                background:#f4f6ff;
                overflow-x:hidden;
            }
            a{
                text-decoration:none;
            }
            img{
                max-width:100%;
            }
            .container{
                width:100%;
                min-height:100vh;
                display:flex;
            }
            .left-panel{
                width:48%;
                position:relative;
                background: linear-gradient( rgba(4,10,40,.55), rgba(4,10,40,.75) ), url("img/rocket-bg.png");
                background-size:cover;
                background-position:center;
                background-repeat:no-repeat;
                color:#fff;
            }
            .overlay{
                position:absolute;
                inset:0;
                background: linear-gradient( rgba(8,15,55,.20), rgba(8,15,55,.65) );
            }
            .left-content{
                position:absolute;
                left:60px;
                top:90px;
                width:80%;
                z-index:2;
            }
            .logo-icon{
                font-size:48px;
                color:#6f6fff;
                margin-bottom:30px;
            }
            .left-content h1{
                font-size:70px;
                font-weight:800;
                line-height:72px;
                margin-bottom:30px;
            }
            .left-content h1 span{
                color:#6f6fff;
            }
            .line{
                width:90px;
                height:5px;
                background:#6f6fff;
                border-radius:20px;
                margin-bottom:40px;
            }
            .left-content p{
                font-size:22px;
                line-height:42px;
                color:#f1f1f1;
                margin-bottom:70px;
            }
            .left-content p span{
                color:#8a94ff;
                font-weight:600;
            }
            .feature-panel{
                display:flex;
                width:520px;
                border-radius:20px;
                overflow:hidden;
                background:rgba(255,255,255,.08);
                backdrop-filter:blur(12px);
                border:1px solid rgba(255,255,255,.15);
                box-shadow:0 10px 30px rgba(0,0,0,.25);
            }
            .feature-box{
                flex:1;
                padding:35px 20px;
                text-align:center;
                border-right:1px solid rgba(255,255,255,.15);
            }
            .feature-box:last-child{
                border-right:none;
            }
            .feature-box i{
                font-size:40px;
                color:#6f6fff;
                margin-bottom:18px;
            }
            .feature-box h4{
                font-size:22px;
                font-weight:600;
            }
            .right-panel{
                width:52%;
                min-height:100vh;
                background:#f8f8ff;
                display:flex;
                justify-content:center;
                align-items:center;
                position:relative;
            }
            .curve{
                position:absolute;
                left:-140px;
                top:0;
                width:280px;
                height:100%;
                background:#f8f8ff;
                border-radius:50%;
                box-shadow:-5px 0 15px rgba(0,0,0,.05);
            }
            .login-card{
                width:520px;
                background:#fff;
                border-radius:30px;
                padding:45px;
                box-shadow:0 20px 60px rgba(0,0,0,.08);
                z-index:5;
            }
            .user-circle{
                width:100px;
                height:100px;
                margin:0 auto 25px;
                border-radius:50%;
                display:flex;
                justify-content:center;
                align-items:center;
                background:linear-gradient(135deg,#eef0ff,#dfe5ff);
            }
            .user-circle img{
                width:90px;
                height:90px;
            }
            .login-card h2{
                text-align:center;
                font-size:42px;
                color:#1b2147;
                margin-bottom:10px;
            }
            .subtitle{
                text-align:center;
                color:#666;
                margin-bottom:30px;
                font-size:17px;
            }
            .server-error{
                background:#ffe9e9;
                color:#c62828;
                border:1px solid #f5b5b5;
                border-radius:10px;
                padding:12px;
                margin-bottom:20px;
                text-align:center;
                font-size:15px;
            }
            .field-error{
                display:block;
                color:#dc3545;
                font-size:13px;
                margin-bottom:10px;
                min-height:18px;
            }
            form label{
                display:block;
                margin-top:18px;
                margin-bottom:8px;
                font-size:16px;
                font-weight:600;
                color:#333;
            }
            .input-box{
                position:relative;
                margin-bottom:6px;
            }
            .input-box input{
                width:100%;
                height:58px;
                border:1px solid #d9d9d9;
                border-radius:12px;
                outline:none;
                padding-left:18px;
                padding-right:50px;
                font-size:16px;
                transition:.3s;
            }
            .input-box input:focus{
                border-color:#5b6cff;
                box-shadow:0 0 10px rgba(91,108,255,.25);
            }
            .input-box i{
                position:absolute;
                right:18px;
                top:20px;
                color:#666;
                cursor:pointer;
            }
            button{
                width:100%;
                height:58px;
                margin-top:20px;
                border:none;
                border-radius:12px;
                background:linear-gradient(90deg,#4d6fff,#6d4cff);
                color:white;
                font-size:20px;
                font-weight:600;
                cursor:pointer;
                transition:.3s;
            }
            button:hover{
                transform:translateY(-2px);
                box-shadow:0 15px 25px rgba(77,111,255,.30);
            }
            button i{
                margin-left:8px;
            }
            .btn-back{
                display:inline-flex;
                align-items:center;
                gap:8px;
                margin-top:20px;
                padding:12px 22px;
                border-radius:10px;
                background:#eef2ff;
                color:#4d6fff;
                font-weight:600;
                text-decoration:none;
                border:1px solid #d8ddff;
                transition:.3s;
            }
            .btn-back:hover{
                background:#4d6fff;
                color:#fff;
                border-color:#4d6fff;
                transform:translateY(-2px);
                box-shadow:0 10px 20px rgba(77,111,255,.30);
            }
            .footer{
                margin-top:35px;
                text-align:center;
                color:#888;
                font-size:14px;
            }
            .footer i{
                color:#5b6cff;
                margin-right:6px;
            }
            @media(max-width:992px){
                .container{
                    flex-direction:column;
                }
                .left-panel{
                    width:100%;
                    height:320px;
                }
                .left-content{
                    top:45px;
                }
                .left-content h1{
                    font-size:48px;
                    line-height:52px;
                }
                .feature-panel{
                    display:none;
                }
                .right-panel{
                    width:100%;
                    padding:30px;
                    min-height:auto;
                }
                .curve{
                    display:none;
                }
                .login-card{
                    width:100%;
                    max-width:520px;
                    padding:35px;
                }
            }
            @media(max-width:576px){
                .login-card{
                    padding:25px;
                }
                .login-card h2{
                    font-size:32px;
                }
                .left-content{
                    left:25px;
                }
                .left-content h1{
                    font-size:38px;
                    line-height:44px;
                }
                .left-content p{
                    font-size:18px;
                    line-height:32px;
                }
            }

            /* Add this new class to handle the alignment of the buttons */
            .action-links {
                display: flex;
                justify-content: space-between; /* Pushes buttons to opposite sides */
                align-items: center;
                gap: 10px;
                margin-top: 25px;
            }

            .btn-back {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                padding: 10px 15px;
                border-radius: 10px;
                background: #eef2ff;
                color: #4d6fff;
                font-weight: 600;
                text-decoration: none;
                border: 1px solid #d8ddff;
                transition: .3s;
                font-size: 14px;
                flex: 1; /* Makes both buttons equal width */
                text-align: center;
            }

            .btn-back:hover {
                background: #4d6fff;
                color: #fff;
                border-color: #4d6fff;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(77,111,255,.20);
            }
        </style>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const loginForm = document.getElementById("loginForm");
                const username = document.getElementById("username");
                const password = document.getElementById("password");
                const usernameError = document.getElementById("usernameError");
                const passwordError = document.getElementById("passwordError");
                const eye = document.getElementById("eye");
                function validateUsername() {
                    let value = username.value.trim();
                    if (value === "") {
                        usernameError.innerHTML = "Username is required.";
                        return false;
                    }
                    if (value.length < 3) {
                        usernameError.innerHTML = "Minimum 3 characters required.";
                        return false;
                    }
                    if (value.length > 20) {
                        usernameError.innerHTML = "Maximum 20 characters allowed.";
                        return false;
                    }
                    let pattern = /^[A-Za-z0-9._@-]+$/;
                    if (!pattern.test(value)) {
                        usernameError.innerHTML = "Only letters, numbers, ., _, -, @ allowed.";
                        return false;
                    }
                    usernameError.innerHTML = "";
                    return true;
                }
                function validatePassword() {
                    let value = password.value.trim();
                    if (value === "") {
                        passwordError.innerHTML = "Password is required.";
                        return false;
                    }
                    if (value.length < 4) {
                        passwordError.innerHTML = "Minimum 4 characters required.";
                        return false;
                    }
                    if (value.length > 30) {
                        passwordError.innerHTML = "Maximum 30 characters allowed.";
                        return false;
                    }
                    passwordError.innerHTML = "";
                    return true;
                }
                loginForm.addEventListener("submit", function (e) {
                    let isUserValid = validateUsername();
                    let isPassValid = validatePassword();
                    if (!isUserValid || !isPassValid) {
                        e.preventDefault();
                    }
                });
                eye.addEventListener("click", function () {
                    if (password.type === "password") {
                        password.type = "text";
                        eye.classList.remove("fa-eye");
                        eye.classList.add("fa-eye-slash");
                    } else {
                        password.type = "password";
                        eye.classList.remove("fa-eye-slash");
                        eye.classList.add("fa-eye");
                    }
                });
            });
        </script>
    </body>
</html>