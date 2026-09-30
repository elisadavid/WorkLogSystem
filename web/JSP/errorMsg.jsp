<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<jsp:include page="../header.jsp"></jsp:include>--%>
<%--<jsp:include page="../sideMenu.jsp"></jsp:include>--%>




<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>System Error</title>
        <!-- Adding FontAwesome for the arrow icon -->
        <!--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">-->
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            body {
                background-color: #f7f9fc;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }
            /* The Main Error Card */
            .error-card {
                background-color: white;
                width: 100%;
                max-width: 600px;
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.1);
                text-align: center;
                border-top: 5px solid #ef4444;
            }
            .error-header {
                background: antiquewhite;
                color: #b91c1c;
                padding: 10px;
                border-radius: 6px;
                font-weight: bold;
                margin-bottom: 20px;
                text-transform: uppercase;
                font-size: 1.1rem;
            }
            .error-messages {
                color: red;
                text-align: left;
                margin: 20px 0;
                padding-left: 20px;
                line-height: 1.6;
                font-weight: 500;
            }
            .alert-text {
                color: #ef4444;
                font-weight: bold;
                font-size: 1.2rem;
                margin-bottom: 10px;
            }
            .message-text {
                color: #6b7280;
                margin-bottom: 20px;
            }
            /* Back Button Styling */
            .back-button {
                cursor: pointer;
                border: none;
                color: white;
                padding: 12px 25px;
                border-radius: 8px;
                font-weight: 600;
                font-size: 1rem;
                background: linear-gradient(to bottom, #c1981e 0%, #554821 100%);
                transition: all 0.3s ease;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            }
            .back-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 12px rgba(0,0,0,0.2);
                opacity: 0.9;
            }
            .back-button:active {
                transform: translateY(0);
            }
        </style>
    </head>
    <body>

        <div class="error-card">
            <!-- Keep your JSTL Logic Exactly the Same -->
            <c:set var="errorList" value=""/>
            <c:set var="comas" value=""/>

            <c:forEach var="arrError" items="${arrErrorLog}">
                <c:if test="${errorList ne ''}">
                    <c:set var="comas" value=", "/>
                </c:if>
                <c:set var="errorList" value="${errorList}${comas}<br>${arrError.errorMsg}"/>
            </c:forEach>

            <c:if test="${errorList ne ''}">
                <div class="error-header">ERROR!</div>
                <div class="error-messages">
                    ${errorList}
                </div>
                <!--            <button class="back-button" onclick="history.back()">
                                <i class="fas fa-arrow-left"></i>&nbsp;Go Back
                            </button>-->
            </c:if>

            <c:if test="${errorList eq ''}">
                <div class="alert-text">ALERT!!! INVALID LOGIN/INVALID INPUT</div>
                <div class="message-text">${Message}</div>
                <!--<a href="registerController?actionType=registration" class="back-button"> Go Back </a>-->

                <button class="back-button" onclick="funBack()">
                    <i class="fas fa-arrow-left"></i>&nbsp;Go Back
                </button>
            </c:if>
        </div>

    </body>
</html>

<script>
    function funBack() {
        // This redirects the browser to the login page
        window.location.href = "mylogin.jsp";
    }
</script>



<%--<jsp:include page="../footer.jsp"></jsp:include>--%>