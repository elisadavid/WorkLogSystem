<%@page import="model.StaffDesignation"%>
<%@page import="java.util.List"%>
<%@page import="model.errorvalidate"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Officer Registration | Worklog System</title>
        <link rel="stylesheet" href="./plugins/fontawesome-free/css/all.min.css">
        <link rel="stylesheet" href="./dist/css/adminlte.min.css">
        <style>
            :root {
                /* Blue Gradient Palette */
                --primary-gradient: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
                --accent-blue: #2563eb;
                --accent-hover: #1d4ed8;
                --bg-gradient: linear-gradient(135deg, #e0e7ff 0%, #f8fafc 100%);
                --card-bg: rgba(255, 255, 255, 0.95);
                --text-main: #1e3a8a;
                --text-muted: #64748b;
                --border-color: #bfdbfe;
                --error-color: #ef4444;
                --input-focus: #3b82f6;
            }

            body {
                margin: 0;
                padding: 0;
                font-family: 'Inter', sans-serif;
                background: var(--bg-gradient);
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                color: var(--text-main);
                padding: 20px;
            }

            .header-section {
                text-align: center;
                margin-bottom: 30px;
            }

            .header-section h1 {
                font-size: 32px;
                font-weight: 800;
                text-transform: uppercase;
                background: var(--primary-gradient);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                letter-spacing: 1px;
            }

            .subtitle {
                color: var(--text-muted);
                font-size: 15px;
                margin-top: 5px;
            }

            .registration-card {
                background: var(--card-bg);
                padding: 40px;
                width: 100%;
                max-width: 750px;
                border-radius: 24px;
                box-shadow: 0 25px 50px -12px rgba(30, 58, 138, 0.15);
                border: 1px solid rgba(255, 255, 255, 0.3);
                backdrop-filter: blur(10px);
            }

            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 25px;
            }

            .form-group {
                margin-bottom: 20px;
                position: relative;
            }

            .form-group label {
                font-size: 13px;
                font-weight: 700;
                margin-bottom: 8px;
                display: block;
                color: var(--text-main);
            }

            .input-wrapper, .input-group {
                position: relative;
                display: flex;
                align-items: center;
            }

            .form-control {
                width: 100%;
                height: 48px;
                padding: 10px 40px 10px 15px;
                border: 2px solid var(--border-color);
                border-radius: 12px;
                font-size: 14px;
                transition: all 0.3s ease;
                background-color: #fcfdfe;
            }

            .form-control:focus {
                outline: none;
                border-color: var(--input-focus);
                box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
                background-color: #fff;
            }

            .input-icon {
                position: absolute;
                right: 15px;
                color: var(--text-muted);
                z-index: 5;
                font-size: 16px;
            }

            .text-danger, .error-text {
                color: var(--error-color);
                font-size: 12px;
                display: none;
                margin-top: 6px;
                font-weight: 500;
            }

            .input-error {
                border: 2px solid var(--error-color) !important;
                background-color: #fff5f5 !important;
            }

            .btn-container {
                display: flex;
                justify-content: space-between;
                gap: 20px;
                margin-top: 30px;
            }

            .btn-submit {
                background: var(--primary-gradient);
                color: white;
                border: none;
                padding: 14px 30px;
                border-radius: 12px;
                font-weight: 700;
                width: 60%;
                cursor: pointer;
                transition: transform 0.2s, box-shadow 0.2s;
                box-shadow: 0 4px 15px rgba(37, 99, 235, 0.3);
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(37, 99, 235, 0.4);
            }

            .btn-cancel {
                background: white;
                color: var(--text-muted);
                border: 2px solid var(--border-color);
                padding: 14px 30px;
                border-radius: 12px;
                width: 35%;
                text-decoration: none;
                text-align: center;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-cancel:hover {
                background: #f1f5f9;
                border-color: var(--text-muted);
                color: var(--text-main);
            }

            .input-group-text {
                position: absolute;
                right: 12px;
                top: 50%;
                transform: translateY(-50%);
                background: transparent !important;
                border: none !important;
                color: var(--text-muted) !important;
                cursor: pointer;
                z-index: 10;
                display: flex;
                align-items: center;
            }

            @media (max-width: 600px) {
                .form-row {
                    grid-template-columns: 1fr;
                }
                .registration-card {
                    padding: 25px;
                }
            }
        </style>
    </head>
    <body>
        <%
            // MATCHING THE CONTROLLER: case "registration"
            // List<StaffDesignation> list = objOfficerDAO.getAllDesignations(connection);
            // request.setAttribute("arrDesignation", list);
            ArrayList<StaffDesignation> arrDesignation = (ArrayList<StaffDesignation>) request.getAttribute("arrDesignation");

            String selectedDesignationId = request.getAttribute("combodesignationId") != null ? (String) request.getAttribute("combodesignationId") : "";
        %>

        <div class="header-section">
            <h1>Officer REGISTRATION</h1>
            <div class="subtitle">Join as a mentor and empower your trainees.</div>
        </div>

        <div class="registration-card">
            <form id="mentorForm" action="officerController" method="post">
                <input type="hidden" name="actionType" value="saveRegistration">
                <input type="hidden" name="regToken" value="<%= request.getAttribute("regToken")%>">

                <div class="form-row">
                    <!-- Officer ID (Mapped to 'staffcode' in Controller) -->

                    <div class="form-group">
                        <select name="role" id="role" required>
                            <option value="">-- Select Role --</option>
                            <option value="OFFICER">Officer</option>
                            <option value="HEAD">Head</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Officer ID / Staff Code</label>
                        <div class="input-wrapper">
                            <input type="text" class="form-control" name="staffcode" id="staffcode" placeholder="Example123" maxlength="7"
                                   onkeypress="return AllowNumCharNoSpace(event)" oninput="this.value = this.value.replace(/\s+/g, '')">
                            <span class="input-icon fas fa-id-badge"></span>
                        </div>
                        <small id="staffcodeError" class="text-danger">Officer ID is Mandatory!!</small>
                    </div>

                    <!-- Officer Name (Mapped to 'fullname' in Controller) -->
                    <div class="form-group">
                        <label>Full Name</label>
                        <div class="input-wrapper">
                            <input type="text" class="form-control" name="fullname" id="fullname"
                                   onkeypress="return AllowCharNoSpace(event)"
                                   oninput="this.value = this.value.replace(/[^A-Za-z\s]/g, '')">
                            <span class="input-icon fas fa-user"></span>
                        </div>
                        <small id="fullnameError" class="text-danger">Full Name is Mandatory!!</small>
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label>Email</label>
                        <div class="input-wrapper">
                            <input type="email" class="form-control" name="email" id="email"
                                   placeholder="officer@company.com"
                                   oninput="this.value = this.value.toLowerCase().replace(/\s+/g, '')"
                                   onblur="validateEmail()">
                            <span class="input-icon fas fa-envelope"></span>
                        </div>
                        <small id="emailError" class="text-danger">Valid Email is Mandatory!!</small>
                    </div>

                    <!-- Phone -->
                    <div class="form-group">
                        <label>Phone Number</label>
                        <div class="input-wrapper">
                            <input type="text" class="form-control" name="phone" id="phone" maxlength="10"
                                   onkeypress="return AllowNumonly(event)" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                            <span class="input-icon fas fa-phone"></span>
                        </div>
                        <small id="phoneError" class="text-danger">10 Digit Phone is Mandatory!!</small>
                    </div>

                    <!-- Division (Mapped to 'department' in Controller) -->
                    <div class="form-group">
                        <label>Division / Department</label>
                        <div class="input-wrapper">
                            <input type="text" class="form-control" name="department" id="department"
                                   onkeypress="return AllowCharNoSpace(event)" oninput="this.value = this.value.replace(/[^A-Za-z ]/g, '')">
                            <span class="input-icon fas fa-building"></span>
                        </div>
                        <small id="departmentError" class="text-danger">Division is Mandatory!!</small>
                    </div>

                    <!-- Staff Designation Dropdown (Mapped to 'mentdesignationId' in Controller) -->
                    <div class="form-group">
                        <label>Designation</label>
                        <select id="mentdesignationId" name="mentdesignationId" class="form-control">
                            <option value="">--- Select ---</option>
                            <%
                                if (arrDesignation != null) {
                                    for (StaffDesignation obj : arrDesignation) {
                                        String currentId = String.valueOf(obj.getStaffDesignationid());
                            %>
                            <option value="<%= currentId%>" <%= selectedDesignationId.equals(currentId) ? "selected" : ""%>>
                                <%= obj.getStaffDesignation()%>
                            </option>
                            <%
                                    }
                                }
                            %>
                        </select>            
                        <small id="mentdesignationIdError" class="text-danger">Designation is Mandatory!!</small>
                    </div>

                    <!-- Username -->
                    <div class="form-group">
                        <label>Username</label>
                        <div class="input-wrapper">
                            <input type="text" id="username" name="username" class="form-control" placeholder="Enter Username"
                                   oninput="this.value = this.value.replace(/[^A-Za-z0-9_]/g, '').replace(/^\s+/, '')">
                            <span class="input-icon fas fa-at"></span>
                        </div>
                        <small id="usernameError" class="text-danger">Username is Mandatory!!</small>
                    </div>

                    <!-- Password -->
                    <div class="form-group">
                        <label>Password</label>
                        <div class="input-group">
                            <input type="password" name="password" id="password" class="form-control" maxlength="15" oninput="this.value = this.value.replace(/\s+/g, '')">
                            <div class="input-group-text" id="togglePassword">
                                <span class="fas fa-eye tog"></span>
                            </div>
                        </div>
                        <small id="passwordError" class="text-danger">Password is Mandatory!!</small>
                    </div>

                    <!-- Confirm Password -->
                    <div class="form-group">
                        <label>Confirm Password</label>
                        <div class="input-group">
                            <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" maxlength="15" oninput="this.value = this.value.replace(/\s+/g, '')">
                            <div class="input-group-text" id="toggleConfirmPassword">
                                <span class="fas fa-eye tog"></span>
                            </div>
                        </div>
                        <small id="matchError" class="text-danger">Passwords must match!!</small>
                    </div>
                </div>

                <div class="btn-container">
                    <button type="button" id="registerBtn" class="btn-submit">Complete Registration</button>
                    <a href="mylogin.jsp" class="btn-cancel">Cancel</a>
                </div>
            </form>
        </div>

        <script src="./plugins/jquery/jquery.min.js"></script>
        <script>
                                       function AllowNumCharNoSpace(evt) {
                                           var regex = /^[A-Za-z0-9]$/;
                                           var charCode = (evt.which) ? evt.which : evt.keyCode;
                                           var keychar = String.fromCharCode(charCode);
                                           return regex.test(keychar);
                                       }
                                       function AllowNumonly(evt) {
                                           var regex = /^[0-9]$/;
                                           var charCode = (evt.which) ? evt.which : evt.keyCode;
                                           var keychar = String.fromCharCode(charCode);
                                           return regex.test(keychar);
                                       }
                                       function AllowCharNoSpace(event) {
                                           var charCode = (event.which) ? event.which : event.keyCode;
                                           if ((charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122) || charCode == 32) {
                                               return true;
                                           }
                                           return false;
                                       }
                                       function validateEmail() {
                                           const emailInput = document.getElementById('email');
                                           const errorSpan = document.getElementById('emailError');
                                           const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                                           if (emailPattern.test(emailInput.value)) {
                                               errorSpan.style.display = 'none';
                                               emailInput.style.borderColor = '';
                                           } else {
                                               errorSpan.style.display = 'block';
                                               emailInput.style.borderColor = 'red';
                                           }
                                       }
                                       function setupToggle(btnId, fieldId) {
                                           const btn = document.getElementById(btnId);
                                           if (btn) {
                                               btn.addEventListener('click', function () {
                                                   const field = document.getElementById(fieldId);
                                                   const icon = this.querySelector('.tog');
                                                   if (field.type === 'password') {
                                                       field.type = 'text';
                                                       icon.classList.replace('fa-eye', 'fa-eye-slash');
                                                   } else {
                                                       field.type = 'password';
                                                       icon.classList.replace('fa-eye-slash', 'fa-eye');
                                                   }
                                               });
                                           }
                                       }
                                       setupToggle('togglePassword', 'password');
                                       setupToggle('toggleConfirmPassword', 'confirmPassword');

                                       $('#registerBtn').click(function () {
                                           var ctrs = 0;
                                           const fields = ['staffcode', 'fullname', 'email', 'phone', 'department', 'username', 'password'];
                                           fields.forEach(id => {
                                               if ($('#' + id).val().trim() === "") {
                                                   $('#' + id).addClass('input-error');
                                                   $('#' + id + 'Error').show();
                                                   ctrs++;
                                               } else {
                                                   $('#' + id).removeClass('input-error');
                                                   $('#' + id + 'Error').hide();
                                               }
                                           });
                                           if ($('#mentdesignationId').val() === "") {
                                               $('#mentdesignationId').addClass('input-error');
                                               $('#mentdesignationIdError').show();
                                               ctrs++;
                                           } else {
                                               $('#mentdesignationId').removeClass('input-error');
                                               $('#mentdesignationIdError').hide();
                                           }
                                           if ($('#confirmPassword').val().trim() === "" || $('#password').val() !== $('#confirmPassword').val()) {
                                               $('#confirmPassword').addClass('input-error');
                                               $('#matchError').show();
                                               ctrs++;
                                           } else {
                                               $('#confirmPassword').removeClass('input-error');
                                               $('#matchError').hide();
                                           }
                                           if (ctrs === 0) {
                                               $('#mentorForm').submit();
                                           }
                                       });
        </script>
    </body>
</html>