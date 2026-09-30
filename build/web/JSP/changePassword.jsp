<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="headSidemenu.jsp"/>

<style>

    .content-wrapper{
        background:#f4f7fb;
    }

    .password-card{

        max-width:600px;
        margin:50px auto;

        background:#fff;
        border-radius:15px;

        box-shadow:0 10px 25px rgba(0,0,0,.08);

        overflow:hidden;

    }

    .card-header-custom{

        background:linear-gradient(90deg,#1e3a8a,#5758a8);

        color:white;

        padding:18px;

    }

    .card-header-custom h3{

        margin:0;

        font-size:22px;

        font-weight:600;

    }

    .card-body{

        padding:35px;

    }

    .form-control{

        height:46px;

        border-radius:8px;

    }

    .btn-save{

        background:#1e3a8a;

        color:white;

        border:none;

        border-radius:8px;

        padding:10px 35px;

    }

    .btn-save:hover{

        background:#273fa3;

    }

</style>

<div class="content-wrapper">

    <section class="content pt-4">

        <div class="container-fluid">

            <div class="password-card">

                <div class="card-header-custom">

                    <h3>

                        <i class="fas fa-key"></i>

                        Change Password

                    </h3>

                </div>

                <div class="card-body">

                    <form action="HeadController?actionType=changePassword"
                          method="post">

                        <div class="form-group">

                            <label>Current Password</label>

                            <input type="password"
                                   class="form-control"
                                   name="oldPassword"
                                   required>

                        </div>

                        <div class="form-group">

                            <label>New Password</label>

                            <input type="password"
                                   class="form-control"
                                   name="newPassword"
                                   required>

                        </div>

                        <div class="form-group">

                            <label>Confirm Password</label>

                            <input type="password"
                                   class="form-control"
                                   name="confirmPassword"
                                   required>

                        </div>

                        <center>

                            <button class="btn btn-save">

                                <i class="fas fa-save"></i>

                                Update Password

                            </button>

                        </center>

                    </form>

                </div>

            </div>

        </div>

    </section>

</div>

<jsp:include page="../../footer.jsp"/>