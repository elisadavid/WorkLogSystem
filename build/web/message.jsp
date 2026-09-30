<%-- 
    Document   : Message
    Created on : Dec 8, 2017, 2:40:07 PM
    Author     : vssc
--%>

<head>
    <style>
        .btn-navy {
            background-color: #0e5c94;
            font-family: monospace;
            font-size: 135%;
            color: white;
        }

        .btn-navy:hover {

            background-color: #5c829d;
            font-family: monospace;
            font-size: 135%;
            color: white;
        }
    </style>
</head> 
<body style="background: linear-gradient(to right, #0008118a,#85c3e3);">
    <%
        String strMessage = "Sorry!! Error on Page! Kindly contact System Administrator";
    %>
    <form name="frm" id="frm" method ="POST">


        <br><br>
        <div id="tabs" style="width: 100%;">
            <table width="90%" border="1"  class="table" align="center" style="background-color: white">
                <thead>
                <th style="font-family: monospace;font-size: 160%;color: #c72929;">
                    <b>Message</b>
                </th>  </thead>
                <tr>
                    <td style="font-family: inherit;font-size: 125%;color: #052a40"><%=strMessage%><br><br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td> 
                </tr>
                <tr>
                    <td style="float:right;border: hidden"> <button type="button" class="btn btn-navy" onclick="clkOtherCentre()">Close</button>
                    </td> 
                </tr>
            </table>
        </div>
        <br>
    </form> 

</body>
</html>

<script>
    function clkOtherCentre() {

        document.getElementById("frm").action = "SessionController";
        document.getElementById("frm").method = "POST";
        document.getElementById("frm").submit();
    }
</script>
