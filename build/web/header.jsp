<%-- 
    Document   : header
    Created on : 17-Sept-2025, 3:34:06?pm
    Author     : Admin
--%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Worklog System</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <link rel="stylesheet" href="plugins/jquery-ui/jquery-ui.css">

<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">

<link rel="stylesheet" href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">

<link rel="stylesheet" href="plugins/toastr/toastr.min.css">

<link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">

<link rel="stylesheet" href="plugins/select2/css/select2.min.css">

<link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">

<link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">

<link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">

<link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">

<link rel="stylesheet" href="dist/css/adminlte.css">

<link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">

<link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">

<link rel="stylesheet" href="plugins/toastr/toastr.css">

<!--        <link rel="stylesheet" href="plugins/jquery-ui/jquery-ui.css"> 

         Font Awesome 
        <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">

         Ionicons 
        <link rel="stylesheet" href="css/ionicons.min.css">
        <link rel="stylesheet" href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
         Toastr 
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">

        Tempusdominus Bbootstrap 4 

        <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">


        Select2 
        <link rel="stylesheet" href="plugins/select2/css/select2.min.css">  

        <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">

        DataTables 
        <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">

        <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
        <link rel="stylesheet" href="css/onoffswitch.css">

        iCheck 
        <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">

        JQVMap 
        <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">

         Theme style 

        <link rel="stylesheet" href="dist/css/adminlte.css">
        overlayScrollbars 
        <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">

        Daterange picker 
        <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">

        <link rel="stylesheet" href="plugins/bootstrap-datepicker/bootstrap-datepicker.css">

        <link rel="stylesheet" href="plugins/daterangepicker/datepicker.css">

        summernote 
        <link rel="stylesheet" href="plugins/summernote/summernote-bs4.css">

        Google Font: Source Sans Pro 
        <link href="css/font.css" rel="stylesheet">

        <link rel="stylesheet" href="plugins/toastr/toastr.css">-->

        <script src="plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>

    </head>
    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper" >
            <!--226C13-->
            <!--2F921B-->
            <!-- Navbar -->
            <nav class="main-header navbar navbar-expand navbar-dark navbar-info" >

                <!--        <img src="img/title.png" class="img-circle elevation-2" />-->
                <!-- Left navbar links -->
                <ul class="navbar-nav" >
                    <li class="nav-item">
                        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                    </li>
                    <!--li class="nav-item d-none d-sm-inline-block">
                      <a href="index.html" class="nav-link">Home</a>
                    </li-->
                    <div style='font-size:30px; color:white; font-weight:bold;'></div>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <!--                    <li class="nav-item">
                    <a href="../../AdminLTE_3.0.4/web/header.jsp"></a>
                                            <a class="nav-link" href="home.jsp" role="button">
                                                <div class="logout mb-3 bg-warning" style="width: 204%;height: 120%;">
                                                    <span style="/*! margin-top:2107%; */margin-left: 27%;" > <i class="fas fa-home" style="margin-top: 17%;"></i></span></div>
                                            </a>
                                        </li>-->
                    <li class="nav-item">
                        <a class="nav-link" href="logoutController?actionType=logout" role="button">
                            <div class="logout mb-3 bg-danger" style="width: 204%;height: 120%;">
                                <span style="/*! margin-top:2107%; */margin-left: 27%;" > <i class="fas fa-power-off" style="margin-top: 17%;"></i></span></div>
                        </a>
                    </li>
<!--                    <li class="nav-item">
                        <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button">
                            <i class="fas fa-th-large"></i>        </a>      </li>-->
                </ul>
            </nav>
