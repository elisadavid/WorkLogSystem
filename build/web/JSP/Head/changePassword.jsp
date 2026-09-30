<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="headSidemenu.jsp"/>

<div class="content-wrapper">
    <section class="content">
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card mt-5">
                        <div class="card-header bg-primary">
                            <h4 class="text-white mb-0">
                                <i class="fas fa-key"></i>Change Password </h4> </div>
                        <div class="card-body">
                          <% 
    String msg = (String) request.getAttribute("msg");
    String type = (String) request.getAttribute("msgType"); 
    if (msg != null) { 
        // If type is null, default to 'info'
        String alertClass = (type != null) ? type : "info"; 
%>
    <div class="alert alert-<%= alertClass %> alert-dismissible fade show"> 
        <%= msg %> 
        <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
<% 
    } 
%>
                           
                     <form id="changePasswordForm" action="HeadController?actionType=changePassword" method="post">
    <!-- Current Password -->
    <div class="form-group">
        <label>Current Password <span class="text-danger">*</span></label>
        <div class="input-group">
            <input type="password" class="form-control" id="oldPassword" name="oldPassword" autocomplete="current-password" maxlength="20">
            <div class="input-group-append">
                <button class="btn btn-outline-secondary toggle-password" type="button" data-target="oldPassword">
                    <i class="fas fa-eye"></i>
                </button>
            </div>
        </div>
        <small id="oldPasswordError" class="text-danger"></small>
    </div>

    <!-- New Password -->
    <div class="form-group">
        <label>New Password <span class="text-danger">*</span></label>
        <div class="input-group">
            <input type="password" class="form-control" id="newPassword" name="newPassword" autocomplete="new-password" maxlength="20">
            <div class="input-group-append">
                <button class="btn btn-outline-secondary toggle-password" type="button" data-target="newPassword">
                    <i class="fas fa-eye"></i>
                </button>
            </div>
        </div>
        <small id="newPasswordError" class="text-danger"></small>
    </div>

    <!-- Confirm Password -->
    <div class="form-group">
        <label>Confirm Password <span class="text-danger">*</span></label>
        <div class="input-group">
            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" autocomplete="new-password" maxlength="20">
            <div class="input-group-append">
                <button class="btn btn-outline-secondary toggle-password" type="button" data-target="confirmPassword">
                    <i class="fas fa-eye"></i>
                </button>
            </div>
        </div>
        <small id="confirmPasswordError" class="text-danger"></small>
    </div>

    <button type="submit" class="btn btn-primary">
        <i class="fas fa-save"></i> Update Password 
    </button>
</form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<jsp:include page="../../footer.jsp"/>

<script>
    // --- EYE TOGGLE LOGIC ---
    document.querySelectorAll('.toggle-password').forEach(button => {
        button.addEventListener('click', function() {
            // Get the ID of the input field to toggle from the data-target attribute
            const targetId = this.getAttribute('data-target');
            const passwordInput = document.getElementById(targetId);
            const icon = this.querySelector('i');

            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = "password";
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    });

    // --- YOUR EXISTING VALIDATION LOGIC ---
    document.getElementById("changePasswordForm").addEventListener("submit", function (e) {
        let valid = true;
        clearErrors();
        let oldPassword = document.getElementById("oldPassword");
        let newPassword = document.getElementById("newPassword");
        let confirmPassword = document.getElementById("confirmPassword");
        let strongPassword = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&.#_-])[A-Za-z\d@$!%*?&.#_-]{8,20}$/;

        if (oldPassword.value.trim() == "") {
            showError(oldPassword, "oldPasswordError", "Current Password is required.");
            valid = false;
        }
        if (newPassword.value.trim() == "") {
            showError(newPassword, "newPasswordError", "New Password is required.");
            valid = false;
        } else if (!strongPassword.test(newPassword.value)) {
            showError(newPassword, "newPasswordError", "Password must contain Uppercase, Lowercase, Number and Special Character.");
            valid = false;
        }
        if (confirmPassword.value.trim() == "") {
            showError(confirmPassword, "confirmPasswordError", "Confirm Password is required.");
            valid = false;
        } else if (newPassword.value !== confirmPassword.value) {
            showError(confirmPassword, "confirmPasswordError", "Passwords do not match.");
            valid = false;
        }
        if (oldPassword.value === newPassword.value && newPassword.value != "") {
            showError(newPassword, "newPasswordError", "New Password cannot be the same as Current Password.");
            valid = false;
        }
        if (!valid) {
            e.preventDefault();
        }
    });

    function showError(field, id, message) {
        field.classList.add("is-invalid");
        document.getElementById(id).innerHTML = message;
    }

    function clearErrors() {
        document.querySelectorAll(".form-control").forEach(function (input) {
            input.classList.remove("is-invalid");
        });
        document.querySelectorAll(".text-danger").forEach(function (label) {
            label.innerHTML = "";
        });
    }

    document.querySelectorAll("input[type=password]").forEach(function (input) {
        input.addEventListener("input", function () {
            this.value = this.value.trimStart();
        });
    });
</script>