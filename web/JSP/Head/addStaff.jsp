<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.designation"%>
<%@page import="model.errorvalidate"%>
<%
    ArrayList<designation> arrDesignation = (ArrayList<designation>) request.getAttribute("arrDesignation");
    ArrayList<errorvalidate> errorList = (ArrayList<errorvalidate>) request.getAttribute("ErrorList");
    String message = request.getAttribute("message") != null ? request.getAttribute("message").toString() : "";
    String staffId = request.getAttribute("staffId") != null ? request.getAttribute("staffId").toString() : "";
    String staffName = request.getAttribute("staffName") != null ? request.getAttribute("staffName").toString() : "";
    String gender = request.getAttribute("gender") != null ? request.getAttribute("gender").toString() : "";
    String email = request.getAttribute("email") != null ? request.getAttribute("email").toString() : "";
    String phone = request.getAttribute("phone") != null ? request.getAttribute("phone").toString() : "";
    String designation = request.getAttribute("designation") != null ? request.getAttribute("designation").toString() : "";
    String username = request.getAttribute("username") != null ? request.getAttribute("username").toString() : "";
    String staffIdError = "";
    String staffNameError = "";
    String genderError = "";
    String emailError = "";
    String phoneError = "";
    String designationError = "";
    String usernameError = "";
    String passwordError = "";
    if (errorList != null) {
        for (errorvalidate err : errorList) {
            if ("staffId".equals(err.getErrorid())) {
                staffIdError = err.getErrorMsg();
            }
            if ("staffName".equals(err.getErrorid())) {
                staffNameError = err.getErrorMsg();
            }
            if ("gender".equals(err.getErrorid())) {
                genderError = err.getErrorMsg();
            }
            if ("email".equals(err.getErrorid())) {
                emailError = err.getErrorMsg();
            }
            if ("phone".equals(err.getErrorid())) {
                phoneError = err.getErrorMsg();
            }
            if ("designation".equals(err.getErrorid())) {
                designationError = err.getErrorMsg();
            }
            if ("username".equals(err.getErrorid())) {
                usernameError = err.getErrorMsg();
            }
            if ("password".equals(err.getErrorid())) {
                passwordError = err.getErrorMsg();
            }
        }
    }
%>
<jsp:include page="../../header.jsp"/>
<jsp:include page="headSidemenu.jsp"/>
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1> <i class="fas fa-user-plus"></i>
                        Add Mentor </h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <a href="HeadController?actionType=viewStaff"> Staff  </a>  </li>
                        <li class="breadcrumb-item active"> Add Mentor  </li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <% if (errorList != null && !errorList.isEmpty()) {%>
            <div class="alert alert-danger alert-dismissible fade show">  <button type="button"class="close"data-dismiss="alert"> &times; </button>
                <strong> <%=message%> </strong>
            </div>
            <% }%>
            <div class="card card-primary card-outline">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-user-tie mr-2"></i>  Mentor Registration </h3>
                </div>
                <form id="mentorForm"  method="post" action="HeadController?actionType=saveStaff"  autocomplete="off">
                    <div class="card-body">
                        <h5 class="text-primary mb-3"> Staff Details</h5>
                        <div class="row">
                            <!-- STAFF ID -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label> Staff ID <span class="text-danger">*</span> </label>
                                    <input  type="text" id="staffId" name="staffId"  maxlength="7" value="<%=staffId%>"  class="form-control <%=!staffIdError.isEmpty() ? "is-invalid" : ""%>" placeholder="Enter Staff ID"
                                            onkeydown=" if (this.value.length == 0 && event.key === ' ')
                                                        event.preventDefault();"
                                            oninput=" this.value= this.value.replace(/[^A-Za-z0-9]/g,'');">
                                    <div class="invalid-feedback"> <%=staffIdError%> </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label> Staff Name <span class="text-danger">*</span> </label>
                                    <input type="text" id="staffName" name="staffName" value="<%=staffName%>" class="form-control <%=!staffNameError.isEmpty() ? "is-invalid" : ""%>"  placeholder="Enter Staff Name"
                                           onkeydown=" if (this.value.length == 0 && event.key === ' ')
                                                       event.preventDefault();"
                                           oninput=" this.value= this.value .replace(/[^A-Za-z\s]/g,'') .replace(/^\s+/,'');">
                                    <div class="invalid-feedback"> <%=staffNameError%> </div>
                                </div>
                            </div>
                            <div class="col-md-6"> <div class="form-group">
                                    <label>  Gender<span class="text-danger">*</span> </label>
                                    <select id="gender" name="gender" class="form-control <%=!genderError.isEmpty() ? "is-invalid" : ""%>">
                                        <option value="">Select Gender</option>
                                        <option value="Male"  <%=gender.equals("Male") ? "selected" : ""%>>  Male </option>
                                        <option value="Female" <%=gender.equals("Female") ? "selected" : ""%>> Female </option>
                                    </select>
                                    <div class="invalid-feedback"> <%=genderError%> </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>
                                        Email Address
                                        <span class="text-danger">*</span>
                                    </label>
                                    <input
                                        type="email"
                                        id="email"
                                        name="email"
                                        value="<%=email%>"
                                        class="form-control <%=!emailError.isEmpty() ? "is-invalid" : ""%>"
                                        placeholder="Enter Email"
                                        onkeydown="
                                                if (this.value.length == 0 &&
                                                        event.key === ' ')
                                                    event.preventDefault();"
                                        oninput="
                                        this.value=this.value.replace(/\s/g,'');">
                                    <div class="invalid-feedback">
                                        <%=emailError%>
                                    </div>
                                </div>
                            </div>
                            <!-- PHONE -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>
                                        Phone Number
                                        <span class="text-danger">*</span>
                                    </label>
                                    <input
                                        type="text"
                                        id="phone"
                                        name="phone"
                                        maxlength="10"
                                        value="<%=phone%>"
                                        class="form-control <%=!phoneError.isEmpty() ? "is-invalid" : ""%>"
                                        placeholder="Enter Phone Number"
                                        onkeydown="
                                                if (this.value.length == 0 &&
                                                        event.key === ' ')
                                                    event.preventDefault();"
                                        oninput="
                                        this.value=this.value.replace(/[^0-9]/g,'');">
                                    <div class="invalid-feedback">
                                        <%=phoneError%>
                                    </div>
                                </div>
                            </div>
                            <!-- DESIGNATION -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>
                                        Designation
                                        <span class="text-danger">*</span>
                                    </label>
                                    <input
                                        type="text"
                                        id="designation"
                                        name="designation"
                                        value="<%=designation%>"
                                        class="form-control <%=!designationError.isEmpty() ? "is-invalid" : ""%>"
                                        placeholder="Enter Designation"
                                        onkeydown="
                                                if (this.value.length == 0 &&
                                                        event.key === ' ')
                                                    event.preventDefault();"
                                        oninput="
                                        this.value=
                                        this.value
                                        .replace(/[^A-Za-z\s]/g,'')
                                        .replace(/^\s+/,'');">
                                    <div class="invalid-feedback">
                                        <%=designationError%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <h5 class="text-primary mb-3">
                            Login Details
                        </h5>
                        <div class="row">
                            <!-- USERNAME -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>
                                        Username
                                        <span class="text-danger">*</span>
                                    </label>
                                    <input
                                        type="text"
                                        id="username"
                                        name="username"
                                        value="<%=username%>"
                                        class="form-control <%=!usernameError.isEmpty() ? "is-invalid" : ""%>"
                                        placeholder="Enter Username"
                                        onkeydown="
                                                if (this.value.length == 0 &&
                                                        event.key === ' ')
                                                    event.preventDefault();"
                                        oninput="
                                        this.value=
                                        this.value.replace(/[^A-Za-z0-9_]/g,'');">
                                    <div class="invalid-feedback">
                                        <%=usernameError%>
                                    </div>
                                </div>
                            </div>
                            <!-- PASSWORD -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>
                                        Password
                                        <span class="text-danger">*</span> </label>
                                    <div class="input-group">
                                        <input type="password" id="password"name="password" class="form-control <%=!passwordError.isEmpty() ? "is-invalid" : ""%>"  placeholder="Enter Password"
                                               onkeydown="  if (this.value.length == 0 && event.key === ' ')
                                                           event.preventDefault();" oninput="  this.value=this.value.replace(/^\s+/,'');">
                                        <div class="input-group-append">
                                            <button
                                                type="button"
                                                class="btn btn-outline-secondary"
                                                id="togglePassword">
                                                <i
                                                    id="passwordIcon"
                                                    class="fas fa-eye">
                                                </i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="text-danger">  <%=passwordError%> </div>
                                </div>
                            </div>
                        </div>
                        <div  id="clientError"class="alert alert-danger" style="display:none;">
                            Please correct the highlighted fields. </div>
                    </div>
                    <div class="card-footer">
                        <button
                            type="submit"
                            class="btn btn-success">
                            <i class="fas fa-save"></i>
                            Save Mentor
                        </button>
                        <button
                            type="reset"
                            class="btn btn-secondary"
                            id="resetButton">
                            <i class="fas fa-redo"></i>
                            Reset
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </section>
</div>

<jsp:include page="../../footer.jsp"/>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("mentorForm");
        const clientError = document.getElementById("clientError");
        const password = document.getElementById("password");
        const togglePassword = document.getElementById("togglePassword");
        const passwordIcon = document.getElementById("passwordIcon");
        //==============================
        // SHOW / HIDE PASSWORD
        //==============================
        togglePassword.addEventListener("click", function () {
            if (password.type === "password") {
                password.type = "text";
                passwordIcon.classList.remove("fa-eye");
                passwordIcon.classList.add("fa-eye-slash");
            } else {
                password.type = "password";
                passwordIcon.classList.remove("fa-eye-slash");
                passwordIcon.classList.add("fa-eye");
            }
        });
        //==============================
        // REMOVE OLD CLIENT ERRORS
        //==============================
        function clearErrors() {
            document.querySelectorAll(".invalid-feedback.client").forEach(function (el) {
                el.remove();
            });
            document.querySelectorAll(".is-invalid").forEach(function (el) {
                el.classList.remove("is-invalid");
            });
            clientError.style.display = "none";
        }
        //==============================
        // SHOW ERROR
        //==============================
        function showError(field, message) {
            field.classList.add("is-invalid");
            let div = document.createElement("div");
            div.className = "invalid-feedback client";
            div.innerHTML = message;
            field.parentNode.appendChild(div);
        }
        //==============================
        // VALIDATE STAFF ID
        //==============================
        function validateStaffId() {
            let field = document.getElementById("staffId");
            let value = field.value.trim();
            if (value === "") {
                showError(field, "Staff ID is required.");
                return false;
            }
            if (!/^[A-Za-z0-9]{7}$/.test(value)) {
                showError(field, "Staff ID must contain exactly 7 letters or numbers.");
                return false;
            }
            return true;
        }
        //==============================
        // VALIDATE STAFF NAME
        //==============================
        function validateStaffName() {
            let field = document.getElementById("staffName");
            let value = field.value.trim();
            if (value === "") {
                showError(field, "Staff Name is required.");
                return false;
            }
            if (!/^[A-Za-z ]+$/.test(value)) {
                showError(field, "Letters only allowed.");
                return false;
            }
            return true;
        }
        //==============================
        // GENDER
        //==============================
        function validateGender() {
            let field = document.getElementById("gender");
            if (field.value === "") {
                showError(field, "Please select Gender.");
                return false;
            }
            return true;
        }
        function validateEmail() {
            let field = document.getElementById("email");
            let value = field.value.trim();
            let emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
            if (value === "") {
                showError(field, "Email is required.");
                return false;
            }
            if (!emailRegex.test(value)) {
                showError(field, "Enter valid Email.");
                return false;
            }
            return true;
        }
        function validatePhone() {
            let field = document.getElementById("phone");
            let value = field.value.trim();
            if (value === "") {
                showError(field, "Phone Number is required.");
                return false;
            }
            if (!/^[0-9]{10}$/.test(value)) {
                showError(field, "Phone must contain exactly 10 digits.");
                return false;
            }
            return true;
        }
        function validateDesignation() {
            let field = document.getElementById("designation");
            let value = field.value.trim();
            if (value === "") {
                showError(field, "Designation is required.");
                return false;
            }
            if (!/^[A-Za-z ]+$/.test(value)) {
                showError(field, "Letters only allowed.");
                return false;
            }
            return true;
        }
        function validateUsername() {
            let field = document.getElementById("username");
            let value = field.value.trim();
            if (value === "") {
                showError(field, "Username is required.");
                return false;
            }
            if (!/^[A-Za-z0-9_]{5,30}$/.test(value)) {
                showError(field, "Username must contain 5-30 letters, numbers or underscore.");
                return false;
            }
            return true;
        }
        function validatePassword() {
            let value = password.value;
            let regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,15}$/;
            if (value.trim() === "") {
                showError(password, "Password is required.");
                return false;
            }
            if (!regex.test(value)) {
                showError(password, "Password must contain Uppercase, Lowercase, Number & Special Character.");
                return false;
            }
            return true;
        }
        form.addEventListener("submit", function (e) {
            clearErrors();
            let valid = true;
            valid &= validateStaffId();
            valid &= validateStaffName();
            valid &= validateGender();
            valid &= validateEmail();
            valid &= validatePhone();
            valid &= validateDesignation();
            valid &= validateUsername();
            valid &= validatePassword();
            if (!valid) {
                e.preventDefault();
                clientError.style.display = "block";
            }
        });
        //==============================
        // LIVE VALIDATION
        //==============================
        document.querySelectorAll("input,select").forEach(function (item) {
            item.addEventListener("input", function () {
                clearErrors();
            });
        });
    });
</script>