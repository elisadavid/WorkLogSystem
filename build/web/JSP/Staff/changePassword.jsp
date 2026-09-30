<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.errorvalidate"%>

<%
ArrayList<errorvalidate> errorList =
        (ArrayList<errorvalidate>) request.getAttribute("ErrorList");

String oldPasswordError = "";
String newPasswordError = "";
String confirmPasswordError = "";

if (errorList != null) {

    for (errorvalidate err : errorList) {

        if ("oldPassword".equals(err.getErrorid())) {
            oldPasswordError = err.getErrorMsg();
        }

        if ("newPassword".equals(err.getErrorid())) {
            newPasswordError = err.getErrorMsg();
        }

        if ("confirmPassword".equals(err.getErrorid())) {
            confirmPasswordError = err.getErrorMsg();
        }
    }
}
%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="staffSideMenu.jsp"/>

<div class="content-wrapper">

    <section class="content">

        <div class="container-fluid">

            <div class="row justify-content-center">

                <div class="col-md-6">

                    <div class="card mt-5">

                        <div class="card-header bg-primary">

                            <h4 class="text-white mb-0">

                                <i class="fas fa-key"></i>

                                Change Password

                            </h4>

                        </div>

                        <div class="card-body">

                            <%
                                String msg = (String) request.getAttribute("msg");
                                if (msg != null) {
                            %>

                            <div class="alert alert-info">
                                <%=msg%>
                            </div>

                            <%
                                }
                            %>

                            <form id="changePasswordForm"
                                  action="staffController?actionType=changePassword"
                                  method="post"
                                  autocomplete="off">

                                <!-- Current Password -->

                                <div class="form-group">

                                    <label>Current Password <span class="text-danger">*</span></label>

                                    <div class="input-group">

                                        <input type="password"
                                               class="form-control <%=!oldPasswordError.isEmpty() ? "is-invalid" : ""%>"
                                               id="oldPassword"
                                               name="oldPassword"
                                               autocomplete="current-password"
                                               maxlength="15">

                                        <div class="input-group-append">

                                            <button type="button"
                                                    class="btn btn-outline-secondary togglePassword"
                                                    data-target="oldPassword">

                                                <i class="fas fa-eye"></i>

                                            </button>

                                        </div>

                                        <% if (!oldPasswordError.isEmpty()) {%>

                                        <div class="invalid-feedback">

                                            <%=oldPasswordError%>

                                        </div>

                                        <% }%>

                                    </div>

                                </div>

                                <!-- New Password -->

                                <div class="form-group">

                                    <label>New Password <span class="text-danger">*</span></label>

                                    <div class="input-group">

                                        <input type="password"
                                               class="form-control <%=!newPasswordError.isEmpty() ? "is-invalid" : ""%>"
                                               id="newPassword"
                                               name="newPassword"
                                               autocomplete="new-password"
                                               maxlength="15">

                                        <div class="input-group-append">

                                            <button type="button"
                                                    class="btn btn-outline-secondary togglePassword"
                                                    data-target="newPassword">

                                                <i class="fas fa-eye"></i>

                                            </button>

                                        </div>

                                        <% if (!newPasswordError.isEmpty()) {%>

                                        <div class="invalid-feedback">

                                            <%=newPasswordError%>

                                        </div>

                                        <% }%>

                                    </div>

                                </div>

                                <!-- Confirm Password -->

                                <div class="form-group">

                                    <label>Confirm Password <span class="text-danger">*</span></label>

                                    <div class="input-group">

                                        <input type="password"
                                               class="form-control <%=!confirmPasswordError.isEmpty() ? "is-invalid" : ""%>"
                                               id="confirmPassword"
                                               name="confirmPassword"
                                               autocomplete="new-password"
                                               maxlength="15">

                                        <div class="input-group-append">

                                            <button type="button"
                                                    class="btn btn-outline-secondary togglePassword"
                                                    data-target="confirmPassword">

                                                <i class="fas fa-eye"></i>

                                            </button>

                                        </div>

                                        <% if (!confirmPasswordError.isEmpty()) {%>

                                        <div class="invalid-feedback">

                                            <%=confirmPasswordError%>

                                        </div>

                                        <% }%>

                                    </div>

                                </div>

                                <button type="submit" class="btn btn-primary">

                                    <i class="fas fa-save"></i>

                                    Update Password

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
document.addEventListener("DOMContentLoaded", function () {

    const form = document.getElementById("changePasswordForm");

    const oldPassword = document.getElementById("oldPassword");
    const newPassword = document.getElementById("newPassword");
    const confirmPassword = document.getElementById("confirmPassword");

    // Password Pattern
    const passwordPattern =
            /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,15}$/;

    //==========================
    // NO SPACE ALLOWED
    //==========================

    function blockSpaces(field) {

        // Prevent pressing Space key
        field.addEventListener("keydown", function (e) {

            if (e.key === " ") {
                e.preventDefault();
            }

        });

        // Remove spaces from typing/paste
        field.addEventListener("input", function () {

            this.value = this.value.replace(/\s/g, "");

        });

        // Remove spaces from paste
        field.addEventListener("paste", function () {

            let input = this;

            setTimeout(function () {

                input.value = input.value.replace(/\s/g, "");

            }, 0);

        });

    }

    blockSpaces(oldPassword);
    blockSpaces(newPassword);
    blockSpaces(confirmPassword);

    //==========================
    // SHOW ERROR
    //==========================

    function showError(input, message) {

        input.classList.add("is-invalid");

        let old = input.parentNode.querySelector(".client-error");

        if (old)
            old.remove();

        let div = document.createElement("div");

        div.className = "invalid-feedback client-error";

        div.innerHTML = message;

        input.parentNode.appendChild(div);

    }

    //==========================
    // CLEAR ERRORS
    //==========================

    function clearErrors() {

        document.querySelectorAll(".client-error").forEach(function (e) {

            e.remove();

        });

        document.querySelectorAll(".form-control").forEach(function (e) {

            e.classList.remove("is-invalid");

        });

    }

    //==========================
    // FORM VALIDATION
    //==========================

    form.addEventListener("submit", function (e) {

        clearErrors();

        let valid = true;

        if (oldPassword.value === "") {

            showError(oldPassword,
                    "Current Password is required.");

            valid = false;
        }

        if (newPassword.value === "") {

            showError(newPassword,
                    "New Password is required.");

            valid = false;

        } else if (!passwordPattern.test(newPassword.value)) {

            showError(newPassword,
                    "Password must contain Uppercase, Lowercase, Number, Special Character and be 8-15 characters.");

            valid = false;

        }

        if (confirmPassword.value === "") {

            showError(confirmPassword,
                    "Confirm Password is required.");

            valid = false;

        } else if (newPassword.value !== confirmPassword.value) {

            showError(confirmPassword,
                    "Passwords do not match.");

            valid = false;

        }

        if (!valid) {

            e.preventDefault();

        }

    });

    //==========================
    // SHOW / HIDE PASSWORD
    //==========================

    document.querySelectorAll(".togglePassword").forEach(function (button) {

        button.addEventListener("click", function () {

            const input =
                    document.getElementById(button.dataset.target);

            const icon =
                    button.querySelector("i");

            if (input.type === "password") {

                input.type = "text";

                icon.classList.remove("fa-eye");

                icon.classList.add("fa-eye-slash");

            } else {

                input.type = "password";

                icon.classList.remove("fa-eye-slash");

                icon.classList.add("fa-eye");

            }

        });

    });

});
</script>