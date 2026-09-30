<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Welcome | Trainee Management System</title>

        <style>

            *{
                margin:0;
                padding:0;
                box-sizing:border-box;
                font-family:'Segoe UI',sans-serif;
            }

            body{
                background:url("img/worklog.png") no-repeat center center fixed;
                background-size:cover;
            }

            .overlay{
                width:100%;
                height:100vh;
                background:rgba(0,0,0,0.45);

                display:flex;
                justify-content:center;
                align-items:center;
            }

            .btn{
                width:260px;
                height:60px;

                border:none;
                border-radius:50px;

                background:linear-gradient(135deg,#007BFF,#0056b3);
                color:white;

                font-size:22px;
                font-weight:bold;

                cursor:pointer;

                box-shadow:0 10px 25px rgba(0,0,0,.4);
                transition:.3s;
            }

            .btn:hover{
                background:linear-gradient(135deg,#0056b3,#003d80);
                transform:scale(1.05);
            }
            .button-row{
    display:flex;
    flex-direction:row;
    justify-content:center;
    align-items:center;
    gap:30px;

    margin-top:120px;
}

        </style>

    </head>

    <body>

        <div class="overlay">

            <div class="button-row">

<!--                 Add Trainee 
                <form action="officerController?actionType=addTrainee" method="post">
                    <button type="submit" class="btn">
                        👤 Add Trainee
                    </button>
                </form>-->

                <!-- Login -->
                <form action="loginController" method="post">
                    <button type="submit" class="btn">
                        🔐 Login
                    </button>
                </form>

            </div>

        </div>

    </body>
</html>