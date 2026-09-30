<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.designation"%>
<%@page import="model.errorvalidate"%>

<%
    ArrayList<designation> arrDesignation
            = (ArrayList<designation>) request.getAttribute("arrDesignation");

    ArrayList<errorvalidate> errorList
            = (ArrayList<errorvalidate>) request.getAttribute("ErrorList");

    String message = request.getAttribute("message") != null
            ? request.getAttribute("message").toString() : "";

    String traineeId = request.getAttribute("traineeId") != null ? (String) request.getAttribute("traineeId") : "";
    String traineeName = request.getAttribute("TraineeName") != null ? (String) request.getAttribute("TraineeName") : "";
    String gender = request.getAttribute("gender") != null ? (String) request.getAttribute("gender") : "";
    String dob = request.getAttribute("dob") != null ? (String) request.getAttribute("dob") : "";
    String place = request.getAttribute("place") != null ? (String) request.getAttribute("place") : "";
    String branch = request.getAttribute("branch") != null ? (String) request.getAttribute("branch") : "";
    String qualification = request.getAttribute("qualification") != null ? (String) request.getAttribute("qualification") : "";
    String email = request.getAttribute("EmailId") != null ? (String) request.getAttribute("EmailId") : "";
    String phone = request.getAttribute("PhoneNumber") != null ? (String) request.getAttribute("PhoneNumber") : "";
    String joiningDate = request.getAttribute("joiningDate") != null ? (String) request.getAttribute("joiningDate") : "";
    String division = request.getAttribute("Division") != null ? (String) request.getAttribute("Division") : "";
    String designationId = request.getAttribute("combodesignationId") != null ? (String) request.getAttribute("combodesignationId") : "";

    String traineeIdError = "";
    String traineeNameError = "";
    String genderError = "";
    String dobError = "";
    String placeError = "";
    String branchError = "";
    String qualificationError = "";
    String designationError = "";
    String emailError = "";
    String phoneError = "";
    String joiningDateError = "";
    String divisionError = "";

    if (errorList != null) {
        for (errorvalidate err : errorList) {

            if ("traineeId".equals(err.getErrorid())) {
                traineeIdError = err.getErrorMsg();
            }

            if ("TraineeName".equals(err.getErrorid())) {
                traineeNameError = err.getErrorMsg();
            }

            if ("gender".equals(err.getErrorid())) {
                genderError = err.getErrorMsg();
            }

            if ("dob".equals(err.getErrorid())) {
                dobError = err.getErrorMsg();
            }

            if ("place".equals(err.getErrorid())) {
                placeError = err.getErrorMsg();
            }

            if ("branch".equals(err.getErrorid())) {
                branchError = err.getErrorMsg();
            }

            if ("qualification".equals(err.getErrorid())) {
                qualificationError = err.getErrorMsg();
            }

            if ("combodesignationId".equals(err.getErrorid())) {
                designationError = err.getErrorMsg();
            }

            if ("EmailId".equals(err.getErrorid())) {
                emailError = err.getErrorMsg();
            }

            if ("PhoneNumber".equals(err.getErrorid())) {
                phoneError = err.getErrorMsg();
            }

            if ("joiningDate".equals(err.getErrorid())) {
                joiningDateError = err.getErrorMsg();
            }

            if ("Division".equals(err.getErrorid())) {
                divisionError = err.getErrorMsg();
            }
        }
    }
%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="officerSideMenu.jsp"/>

<div class="content-wrapper">

    <section class="content-header">

        <div class="container-fluid">

            <div class="row mb-2">

                <div class="col-sm-6">

                    <h1>
                        <i class="fas fa-user-plus"></i>
                        Add Trainee
                    </h1>

                </div>

            </div>

        </div>

    </section>

    <section class="content">

        <div class="container-fluid">

            <% if (errorList != null && !errorList.isEmpty()) { %>

            <div class="alert alert-danger">

                <h5>

                    <i class="fas fa-exclamation-circle"></i>

                    Please correct the following errors

                </h5>

                <ul class="mb-0">

                    <% for (errorvalidate err : errorList) {%>

                    <li><%=err.getErrorMsg()%></li>

                    <% } %>

                </ul>

            </div>

            <% }%>

            <div class="card card-primary card-outline">

                <div class="card-header">

                    <h3 class="card-title">

                        <i class="fas fa-user-graduate"></i>

                        Trainee Details

                    </h3>

                </div>

                <form id="traineeForm"

                      action="officerController"

                      method="post"

                      autocomplete="off">

                    <input type="hidden"

                           name="actionType"

                           value="saveTraineeDetails">

                    <div class="card-body">

                        <div class="row">

                            <!-- Left Column -->
                            <div class="col-md-6">

                                <!-- Trainee ID -->
                                <div class="form-group">
                                    <label>Trainee ID <span class="text-danger">*</span></label>

                                    <input type="text"
                                           id="traineeId"
                                           name="traineeId"
                                           maxlength="7"
                                           value="<%=traineeId%>"
                                           class="form-control <%=!traineeIdError.isEmpty() ? "is-invalid" : ""%>"
                                           autocomplete="off">

                                    <% if (!traineeIdError.isEmpty()) {%>
                                    <div class="invalid-feedback"><%=traineeIdError%></div>
                                    <% }%>
                                </div>

                                <!-- Name -->
                                <div class="form-group">
                                    <label>Trainee Name <span class="text-danger">*</span></label>

                                    <input type="text"
                                           id="TraineeName"
                                           name="TraineeName"
                                           maxlength="50"
                                           value="<%=traineeName%>"
                                           class="form-control <%=!traineeNameError.isEmpty() ? "is-invalid" : ""%>"
                                           autocomplete="off">

                                    <% if (!traineeNameError.isEmpty()) {%>
                                    <div class="invalid-feedback"><%=traineeNameError%></div>
                                    <% }%>
                                </div>

                                <!-- Gender -->
                                <div class="form-group">

                                    <label>Gender <span class="text-danger">*</span></label>

                                    <select id="gender"
                                            name="gender"
                                            class="form-control <%=!genderError.isEmpty() ? "is-invalid" : ""%>">

                                        <option value="">Select Gender</option>

                                        <option value="Male"
                                                <%=gender.equals("Male") ? "selected" : ""%>>
                                            Male
                                        </option>

                                        <option value="Female"
                                                <%=gender.equals("Female") ? "selected" : ""%>>
                                            Female
                                        </option>

                                    </select>

                                    <% if (!genderError.isEmpty()) {%>
                                    <div class="invalid-feedback"><%=genderError%></div>
                                    <% }%>

                                </div>

                                <!-- DOB -->
                                <div class="form-group">

                                    <label>Date of Birth <span class="text-danger">*</span></label>

                                    <input type="date"
                                           id="dob"
                                           name="dob"
                                           value="<%=dob%>"
                                           class="form-control <%=!dobError.isEmpty() ? "is-invalid" : ""%>">

                                    <% if (!dobError.isEmpty()) {%>
                                    <div class="invalid-feedback"><%=dobError%></div>
                                    <% }%>

                                </div>

                                <!-- Place -->
                                <div class="form-group">

                                    <label>Place</label>

                                    <input type="text"
                                           id="place"
                                           name="place"
                                           maxlength="30"
                                           value="<%=place%>"
                                           class="form-control <%=!placeError.isEmpty() ? "is-invalid" : ""%>"
                                           autocomplete="off">

                                    <% if (!placeError.isEmpty()) {%>
                                    <div class="invalid-feedback"><%=placeError%></div>
                                    <% }%>

                                </div>

                                <!-- Branch -->
                                <div class="form-group">

                                    <label>Branch</label>

                                    <input type="text"
                                           id="branch"
                                           name="branch"
                                           maxlength="30"
                                           value="<%=branch%>"
                                           class="form-control <%=!branchError.isEmpty() ? "is-invalid" : ""%>"
                                           autocomplete="off">

                                    <% if (!branchError.isEmpty()) {%>
                                    <div class="invalid-feedback"><%=branchError%></div>
                                    <% }%>

                                </div>

                            </div>

                            <!-- Right Column -->
                            <div class="col-md-6">

                                <!-- Qualification -->
                                <div class="form-group">

                                    <label>Qualification</label>

                                    <input type="text"
                                           id="qualification"
                                           name="qualification"
                                           maxlength="50"
                                           value="<%=qualification%>"
                                           class="form-control <%=!qualificationError.isEmpty() ? "is-invalid" : ""%>"
                                           autocomplete="off">

                                    <% if (!qualificationError.isEmpty()) {%>
                                    <div class="invalid-feedback"><%=qualificationError%></div>
                                    <% }%>

                                </div>

                                <!-- Designation -->
                                <div class="form-group">

                                    <label>Designation <span class="text-danger">*</span></label>

                                    <select id="combodesignationId"
                                            name="combodesignationId"
                                            class="form-control <%=!designationError.isEmpty() ? "is-invalid" : ""%>">

                                        <option value="">Select Designation</option>

                                        <%
                                            if (arrDesignation != null) {
                                                for (designation obj : arrDesignation) {
                                        %>

                                        <option value="<%=obj.getDesignationId()%>"
                                                <%=designationId.equals(String.valueOf(obj.getDesignationId())) ? "selected" : ""%>>

                                            <%=obj.getDesignation()%>

                                        </option>

                                        <% }
                    } %>

                                    </select>

                                    <% if (!designationError.isEmpty()) {%>
                                    <div class="invalid-feedback"><%=designationError%></div>
                                    <% }%>

                                </div>

                                <!-- Email -->
                                <div class="form-group">

                                    <label>Email <span class="text-danger">*</span></label>

                                    <input type="email"
                                           id="EmailId"
                                           name="EmailId"
                                           value="<%=email%>"
                                           class="form-control <%=!emailError.isEmpty() ? "is-invalid" : ""%>"
                                           autocomplete="off">

                                    <% if (!emailError.isEmpty()) {%>
                                    <div class="invalid-feedback"><%=emailError%></div>
                                    <% }%>

                                </div>

                                <!-- Phone -->
                                <div class="form-group">

                                    <label>Phone Number <span class="text-danger">*</span></label>

                                    <input type="text"
                                           id="PhoneNumber"
                                           name="PhoneNumber"
                                           maxlength="10"
                                           value="<%=phone%>"
                                           class="form-control <%=!phoneError.isEmpty() ? "is-invalid" : ""%>"
                                           autocomplete="off">

                                    <% if (!phoneError.isEmpty()) {%>
                                    <div class="invalid-feedback"><%=phoneError%></div>
                                    <% }%>

                                </div>

                                <!-- Joining Date -->
                                <div class="form-group">

                                    <label>Joining Date <span class="text-danger">*</span></label>

                                    <input type="date"
                                           id="joiningDate"
                                           name="joiningDate"
                                           value="<%=joiningDate%>"
                                           class="form-control <%=!joiningDateError.isEmpty() ? "is-invalid" : ""%>">

                                    <% if (!joiningDateError.isEmpty()) {%>
                                    <div class="invalid-feedback"><%=joiningDateError%></div>
                                    <% }%>

                                </div>

                                <!-- Completion Date -->
                                <div class="form-group">

                                    <label>Completion Date</label>

                                    <input type="date"
                                           id="completionDate"
                                           name="completionDate"
                                           readonly
                                           class="form-control">

                                </div>

                                <!-- Division -->
                                <div class="form-group">

                                    <label>Division <span class="text-danger">*</span></label>

                                    <select id="Division"
                                            name="Division"
                                            class="form-control <%=!divisionError.isEmpty() ? "is-invalid" : ""%>">

                                        <option value="">Select Division</option>

                                        <option value="COM"
                                                <%=division.equals("COM") ? "selected" : ""%>>
                                            COM
                                        </option>

                                        <option value="ESIS"
                                                <%=division.equals("ESIS") ? "selected" : ""%>>
                                            ESIS
                                        </option>

                                    </select>

                                    <% if (!divisionError.isEmpty()) {%>
                                    <div class="invalid-feedback"><%=divisionError%></div>
                                    <% }%>

                                </div>

                            </div>

                        </div>

                        <div class="card-footer text-center">

                            <button type="submit"
                                    class="btn btn-success">
                                <i class="fas fa-save"></i> Save Trainee
                            </button>

                            <button type="reset"
                                    class="btn btn-secondary"
                                    id="resetBtn">
                                <i class="fas fa-redo"></i> Reset
                            </button>

                        </div>

                </form>

            </div>

        </div>

    </section>

</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("traineeForm");

        function showError(id, msg) {
            const field = document.getElementById(id);
            field.classList.add("is-invalid");
            let error = field.parentElement.querySelector(".invalid-feedback");
            if (!error) {
                error = document.createElement("div");
                error.className = "invalid-feedback";
                field.parentElement.appendChild(error);
            }
            error.innerHTML = msg;
        }

        function clearError(field) {
            field.classList.remove("is-invalid");
            let error = field.parentElement.querySelector(".invalid-feedback");
            if (error) {
                error.remove();
            }
        }

        function validEmail(email) {
            return /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(email);
        }

        document.querySelectorAll(".form-control").forEach(function (field) {
            field.addEventListener("input", function () {
                clearError(this);
            });
            field.addEventListener("change", function () {
                clearError(this);
            });
        });

        document.getElementById("traineeId").addEventListener("input", function () {
            this.value = this.value.replace(/^\s+/, ""); // No leading space
            if (this.value.length > 8) {
                this.value = this.value.substring(0, 8);
            }
        });

        const alphaOnlyFields = ["TraineeName", "place", "branch", "qualification"];
        alphaOnlyFields.forEach(id => {
            document.getElementById(id).addEventListener("input", function () {
                this.value = this.value
                        .replace(/[^A-Za-z ]/g, "") // Only letters and spaces
                        .replace(/^\s+/, "")        // No leading space
                        .replace(/\s{2,}/g, " ");   // No double spaces
                if (this.value.length > 25) {
                    this.value = this.value.substring(0, 25);
                }
            });
        });

        document.getElementById("PhoneNumber").addEventListener("input", function () {
            this.value = this.value.replace(/[^0-9]/g, ""); // Only numbers
            this.value = this.value.replace(/^\s+/, "");    // No leading space
            if (this.value.length > 10) {
                this.value = this.value.substring(0, 10);
            }
        });

        document.getElementById("EmailId").addEventListener("input", function () {
            this.value = this.value.replace(/\s/g, "");
        });

        // Completion Date Calculation
        document.getElementById("joiningDate").addEventListener("change", function () {
            if (this.value !== "") {
                let d = new Date(this.value);
                d.setFullYear(d.getFullYear() + 1);
                document.getElementById("completionDate").value = d.toISOString().split("T")[0];
            } else {
                document.getElementById("completionDate").value = "";
            }
        });

        form.addEventListener("submit", function (e) {
            let valid = true;

            document.querySelectorAll(".invalid-feedback").forEach(x => x.remove());
            document.querySelectorAll(".form-control").forEach(x => x.classList.remove("is-invalid"));

            let traineeId = document.getElementById("traineeId").value;
            if (traineeId === "") {
                showError("traineeId", "Trainee ID is required.");
                valid = false;
            } else if (traineeId.startsWith(" ")) {
                showError("traineeId", "Leading spaces are not allowed.");
                valid = false;
            }

            let traineeName = document.getElementById("TraineeName").value;
            if (traineeName.trim() === "") {
                showError("TraineeName", "Trainee Name is required.");
                valid = false;
            } else if (traineeName.startsWith(" ")) {
                showError("TraineeName", "Leading spaces are not allowed.");
                valid = false;
            } else if (!/^[A-Za-z ]+$/.test(traineeName)) {
                showError("TraineeName", "Only alphabets are allowed.");
                valid = false;
            }

            if (document.getElementById("gender").value === "") {
                showError("gender", "Please select Gender.");
                valid = false;
            }

            let dob = document.getElementById("dob").value;
            if (dob === "") {
                showError("dob", "Date of Birth is required.");
                valid = false;
            } else {
                let birth = new Date(dob);
                let today = new Date();
                if (birth > today) {
                    showError("dob", "Date of Birth cannot be in the future.");
                    valid = false;
                } else {
                    let age = today.getFullYear() - birth.getFullYear();
                    let m = today.getMonth() - birth.getMonth();
                    if (m < 0 || (m === 0 && today.getDate() < birth.getDate()))
                        age--;
                    if (age < 18) {
                        showError("dob", "Age must be 18 years or above.");
                        valid = false;
                    }
                }
            }

            const strictFields = [
                {id: "place", label: "Place"},
                {id: "branch", label: "Branch"},
                {id: "qualification", label: "Qualification"}
            ];
            strictFields.forEach(field => {
                let val = document.getElementById(field.id).value;
                if (val.trim() === "") {
                    showError(field.id, field.label + " is required.");
                    valid = false;
                } else if (val.startsWith(" ")) {
                    showError(field.id, "Leading spaces are not allowed.");
                    valid = false;
                } else if (!/^[A-Za-z ]+$/.test(val)) {
                    showError(field.id, "Only alphabets are allowed.");
                    valid = false;
                }
            });

            if (document.getElementById("combodesignationId").value === "") {
                showError("combodesignationId", "Please select Designation.");
                valid = false;
            }

            // Email
            let email = document.getElementById("EmailId").value.trim();
            if (email === "") {
                showError("EmailId", "Email is required.");
                valid = false;
            } else if (!validEmail(email)) {
                showError("EmailId", "Enter a valid Email Address.");
                valid = false;
            }

            let phone = document.getElementById("PhoneNumber").value;
            if (phone === "") {
                showError("PhoneNumber", "Phone Number is required.");
                valid = false;
            } else if (phone.startsWith(" ")) {
                showError("PhoneNumber", "Leading spaces are not allowed.");
                valid = false;
            } else if (!/^[0-9]{10}$/.test(phone)) {
                showError("PhoneNumber", "Enter exactly 10 digits.");
                valid = false;
            }

            let joiningDate = document.getElementById("joiningDate").value;
            if (joiningDate === "") {
                showError("joiningDate", "Joining Date is required.");
                valid = false;
            } else {
                let join = new Date(joiningDate);
                let today = new Date();
                today.setHours(0, 0, 0, 0);
                if (join > today) {
                    showError("joiningDate", "Joining Date cannot be in the future.");
                    valid = false;
                }
            }

            if (document.getElementById("Division").value === "") {
                showError("Division", "Please select Division.");
                valid = false;
            }

            if (!valid) {
                e.preventDefault();
            }
        });


        document.getElementById("resetBtn").addEventListener("click", function () {
            document.querySelectorAll(".invalid-feedback").forEach(x => x.remove());
            document.querySelectorAll(".form-control").forEach(x => x.classList.remove("is-invalid"));
            document.getElementById("completionDate").value = "";
        });
    });
</script>

<style>

    /* -----------------------------
       Invalid Field Style
    ------------------------------ */

    .is-invalid{
        border:2px solid #dc3545 !important;
        box-shadow:none !important;
    }

    .invalid-feedback{
        display:block !important;
        color:#dc3545;
        font-size:13px;
        font-weight:500;
        margin-top:4px;
    }


    /* -----------------------------
       Card
    ------------------------------ */

    .card{
        border-radius:10px;
    }

    .card-header{
        font-weight:bold;
    }


    /* -----------------------------
       Labels
    ------------------------------ */

    label{
        font-weight:600;
    }


    /* -----------------------------
       Inputs
    ------------------------------ */

    .form-control{

        border-radius:6px;

    }

    .form-control:focus{

        box-shadow:none;

    }


    /* -----------------------------
       Buttons
    ------------------------------ */

    .btn{

        min-width:130px;

    }


    /* -----------------------------
       Error Animation
    ------------------------------ */

    .is-invalid{

        animation:shake .25s;

    }

    @keyframes shake{

        0%{
            transform:translateX(0);
        }
        25%{
            transform:translateX(-2px);
        }
        50%{
            transform:translateX(2px);
        }
        75%{
            transform:translateX(-2px);
        }
        100%{
            transform:translateX(0);
        }

    }

</style>

<jsp:include page="../../footer.jsp"/>