<%@page import="model.traineeDetails"%>
<%@page import="model.staffDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.TraineeLeave"%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="traineeSideMenu.jsp"/>

<%
    traineeDetails objTrainee
            = (traineeDetails) request.getAttribute("objTrainee");

    staffDetails objStaff
            = (staffDetails) request.getAttribute("objStaff");

    ArrayList<TraineeLeave> arrLeaveList
            = (ArrayList<TraineeLeave>) request.getAttribute("arrLeaveList");

    Integer clBalance
            = (Integer) request.getAttribute("clBalance");

    Integer sclBalance
            = (Integer) request.getAttribute("sclBalance");

    Integer mlBalance
            = (Integer) request.getAttribute("mlBalance");

    Integer eolBalance
            = (Integer) request.getAttribute("eolBalance");
%>


<style>
    /* MODERN THEME OVERRIDES */
    body {
        background: #f8fafc !important;
        font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif !important;
    }

    .content-wrapper {
        background-color: #f8fafc !important;
    }

    /* Container Card */
    .card-box {
        background: white;
        border-radius: 16px;
        padding: 30px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1),
            0 2px 4px -1px rgba(0, 0, 0, 0.06);
        margin-bottom: 30px;
        border: none;
    }

    .title {
        font-size: 24px;
        font-weight: 700;
        color: #1e293b;
        margin-bottom: 25px;
        position: relative;
        padding-bottom: 10px;
    }

    .title::after {
        content: '';
        position: absolute;
        left: 0;
        bottom: 0;
        width: 50px;
        height: 4px;
        background: #6366f1;
        border-radius: 2px;
    }

    /* Modern Balance Cards */
    .balance-card {
        text-align: center;
        padding: 20px;
        border-radius: 12px;
        background: #fff;
        border: 1px solid #e2e8f0;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .balance-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
    }

    .balance-card h3 {
        font-size: 2rem;
        font-weight: 800;
        margin-bottom: 5px;
        color: #1e293b;
    }

    .balance-card p {
        font-weight: 600;
        color: #64748b;
        margin: 0;
        text-transform: uppercase;
        font-size: 0.75rem;
        letter-spacing: 1px;
    }

    /* Accent strips for balance cards */
    .balance-card::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 4px;
    }

    .cl::before {
        background: #10b981;
    }

    .scl::before {
        background: #06b6d4;
    }

    .ml::before {
        background: #f59e0b;
    }

    .eol::before {
        background: #ef4444;
    }

    /* Modern Table Styling */
    .table {
        border-collapse: separate;
        border-spacing: 0;
    }

    .table thead th {
        background: #f1f5f9 !important;
        color: #475569 !important;
        text-transform: uppercase;
        font-size: 0.75rem;
        font-weight: 700;
        letter-spacing: 0.5px;
        border-bottom: 2px solid #e2e8f0 !important;
        border-top: none !important;
        text-align: center !important;
        padding: 15px !important;
    }

    .table td {
        vertical-align: middle !important;
        text-align: center !important;
        padding: 12px !important;
        border-bottom: 1px solid #f1f5f9 !important;
        color: #64748b;
    }

    /* Table Footer Alignment for Add Button */
    .action-footer-cell {
        background-color: #f8fafc !important;
        border-top: 2px solid #e2e8f0 !important;
        padding: 15px !important;
    }

    /* Form Inputs */
    .form-control {
        border-radius: 8px !important;
        border: 1px solid #cbd5e1 !important;
        padding: 8px 12px !important;
        font-size: 0.9rem !important;
    }

    .form-control:focus {
        border-color: #6366f1 !important;
        box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1) !important;
    }

    /* Buttons */
    .btn-primary {
        background: #6366f1 !important;
        border: none !important;
        font-weight: 600 !important;
    }

    .btn-success {
        background: #10b981 !important;
        border: none !important;
        font-weight: 600 !important;
    }

    .btn-danger {
        background: #ef4444 !important;
        border: none !important;
    }

    .btn-warning {
        background: #f59e0b !important;
        color: white !important;
        border: none !important;
    }

    .btn {
        border-radius: 8px !important;
        padding: 8px 16px !important;
        transition: all 0.2s;
    }

    .btn:hover {
        transform: scale(1.05);
        opacity: 0.9;
    }

    /* Add Row Specific Button */
    .btn-add-row {
        background: #6366f1 !important;
        color: white !important;
        border: none !important;
        font-weight: 600 !important;
        width: 100%;
        border-radius: 8px !important;
        transition: all 0.2s;
    }

    .btn-add-row:hover {
        background: #4f46e5 !important;
        transform: scale(1.02);
    }

    .btn-remove {
        width: 100%;
        display: block;
    }

    /* Status Badges */
    .badge-modern {
        padding: 6px 12px;
        border-radius: 50px;
        font-size: 0.75rem;
        font-weight: 700;
        display: inline-block;
        text-transform: uppercase;
    }

    .bg-approved {
        background: #dcfce7;
        color: #166534;
    }

    .bg-rejected {
        background: #fee2e2;
        color: #991b1b;
    }

    .bg-pending {
        background: #fef3c7;
        color: #92400e;
    }
</style>


<div class="content-wrapper">

    <section class="content">

        <div class="container-fluid">

            <!-- TOP SECTION: Balance & Request -->
            <div class="card-box">

                <div class="title">
                    Leave Management<%=clBalance%>
                </div>


                <!-- LEAVE BALANCE SECTION -->
                <div class="row mb-4">

                    <div class="col-md-3">
                        <div class="balance-card cl">

                            <h3>
                                <%=clBalance%>
                            </h3>

                            <p>
                                Casual Leave
                            </p>

                        </div>
                    </div>


                    <div class="col-md-3">
                        <div class="balance-card scl">

                            <h3>
                                <%= sclBalance%>
                            </h3>

                            <p>
                                Special Leave
                            </p>

                        </div>
                    </div>


                    <div class="col-md-3">
                        <div class="balance-card ml">

                            <h3>
                                <%= mlBalance%>
                            </h3>

                            <p>
                                Medical Leave
                            </p>

                        </div>
                    </div>


                    <div class="col-md-3">
                        <div class="balance-card eol">

                            <h3>
                                <%= eolBalance%>
                            </h3>

                            <p>
                                EOL
                            </p>

                        </div>
                    </div>

                </div>


                <!-- SAVE LEAVE FORM -->
                <form action="traineesController" method="post">

                    <input type="hidden"
                           name="actionType"
                           value="saveLeave">


                    <input type="hidden"
                           name="traineeId"
                           value="<%= session.getAttribute("traineeId")%>">


                    <div class="table-responsive">

                        <table class="table"
                               id="leaveTable">

                            <thead>

                                <tr>

                                    <th>
                                        Leave From
                                    </th>

                                    <th>
                                        Leave To
                                    </th>

                                    <th>
                                        Total Days
                                    </th>

                                    <th>
                                        Leave Type
                                    </th>

                                    <th>
                                        Reason
                                    </th>

                                    <th style="width: 160px;">
                                        Action
                                    </th>

                                </tr>

                            </thead>


                            <tbody id="leaveTbody">

                                <tr>

                                    <td>

                                        <input type="date" name="leaveFrom[]"class="form-control fromDate"
                                               required>

                                    </td>


                                    <td>

                                        <input type="date"
                                               name="leaveTo[]"
                                               class="form-control toDate"
                                               required>

                                    </td>


                                    <td>

                                        <input type="text"
                                               class="form-control totalDays"
                                               readonly
                                               style="background: #f8fafc;">

                                    </td>


                                    <td>

                                        <select name="leaveType[]"
                                                class="form-control">

                                            <option>
                                                Casual Leave
                                            </option>

                                            <option>
                                                Special Leave
                                            </option>

                                            <option>
                                                Medical Leave
                                            </option>

                                            <option>
                                                EOL
                                            </option>

                                        </select>

                                    </td>


                                    <td>

                                        <input type="text"
                                               name="reason[]"
                                               class="form-control"
                                               placeholder="Enter reason..."
                                               required>

                                    </td>


                                    <td>

                                        <button type="button"
                                                class="btn btn-danger btn-remove"
                                                onclick="removeRow(this)">

                                            <i class="fas fa-trash"></i>
                                            Remove

                                        </button>

                                    </td>

                                </tr>

                            </tbody>


                            <!-- FOOTER ALIGNMENT FOR ADD ROW BUTTON -->
                            <tfoot>

                                <tr>

                                    <td colspan="5"
                                        class="action-footer-cell">
                                    </td>


                                    <td class="action-footer-cell">

                                        <button type="button"
                                                class="btn btn-add-row"
                                                onclick="addRow()">

                                            <i class="fas fa-plus-circle"></i>
                                            Add Row

                                        </button>

                                    </td>

                                </tr>

                            </tfoot>

                        </table>

                    </div>


                    <div class="text-center mt-4">

                        <button type="submit"
                                class="btn btn-success btn-lg"
                                style="padding: 12px 40px; font-size: 1rem;">

                            <i class="fas fa-paper-plane"></i>
                            Submit Leave Request

                        </button>

                    </div>

                </form>

            </div>


            <!-- BOTTOM SECTION: Leave History -->
            <div class="card-box">

                <div class="title">
                    Leave History
                </div>


                <div class="table-responsive">

                    <table class="table">


                        <thead>
                            <tr>
                                <th>Leave From</th>
                                <th>Leave To</th>
                                <th>Total Days</th>
                                <th>Leave Type</th>
                                <th>Reason</th>
                                <th>Status</th>
                                <th>Mentor Remark</th>
                                <th>Action</th>
                            </tr>
                        </thead>


                        <tbody>

                            <%

                                /*
                                 * Retrieve leave history from request.
                                 * This replaces JSTL/EL usage with JSP scriptlet.
                                 */
                                ArrayList<TraineeLeave> list
                                        = (ArrayList<TraineeLeave>) request.getAttribute("arrLeaveList");

                                if (list != null) {

                                    for (TraineeLeave obj : list) {

                            %>


                            <tr>

                                <td>
                                    <%        String fromDate = obj.getLeaveFrom();
                                        if (fromDate != null) {
                                            try {
                                                java.text.SimpleDateFormat inFmt = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                java.text.SimpleDateFormat outFmt = new java.text.SimpleDateFormat("dd-MM-yyyy");
                                                out.print(outFmt.format(inFmt.parse(fromDate)));
                                            } catch (Exception e) {
                                                out.print(fromDate);
                                            }
                                        }
                                    %>
                                </td>
                                <td>
                                    <%
                                        String toDate = obj.getLeaveTo();
                                        if (toDate != null) {
                                            try {
                                                java.text.SimpleDateFormat inFmt = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                java.text.SimpleDateFormat outFmt = new java.text.SimpleDateFormat("dd-MM-yyyy");
                                                out.print(outFmt.format(inFmt.parse(toDate)));
                                            } catch (Exception e) {
                                                out.print(toDate);
                                            }
                                        }
                                    %>
                                </td>
                                <td>
                                    <%= obj.getTotalDays()%>
                                </td>

                                <td>
                                    <%= obj.getLeaveType()%>
                                </td>

                                <td>
                                    <%= obj.getReason()%>
                                </td>


                                <!-- STATUS -->
                                <td>

                                    <%

                                        if ("APPROVED".equalsIgnoreCase(
                                                obj.getStatus())) {

                                    %>

                                    <span class="badge-modern bg-approved">
                                        Approved
                                    </span>

                                    <%                                    } else if ("REJECTED".equalsIgnoreCase(
                                            obj.getStatus())) {

                                    %>

                                    <span class="badge-modern bg-rejected">
                                        Rejected
                                    </span>

                                    <%                                    } else {

                                    %>

                                    <span class="badge-modern bg-pending">
                                        Pending
                                    </span>

                                    <%                                        }

                                    %>

                                </td>


                                <!-- MENTOR REMARK -->
                                <td>

                                    <%                                        if (obj.getMentorRemark() == null
                                                || obj.getMentorRemark()
                                                        .trim()
                                                        .equals("")) {

                                    %>

                                    <span style="color:#cbd5e1;">
                                        -
                                    </span>

                                    <%                                    } else {

                                    %>

                                    <span style="color:#ef4444;
                                          font-weight:600;">

                                        <%= obj.getMentorRemark()%>

                                    </span>

                                    <%

                                        }

                                    %>

                                </td>


                                <!-- ACTION -->
                                <td>

                                    <%                                        String status
                                                = obj.getStatus();

                                        if ("PENDING".equalsIgnoreCase(status)
                                                || "REJECTED".equalsIgnoreCase(status)) {

                                    %>


                                    <!-- EDIT BUTTON -->
                                    <button type="button"
                                            class="btn btn-warning btn-sm"
                                            data-toggle="modal"
                                            data-target="#editLeaveModal"
                                            onclick="editLeave(
                                                            '<%= obj.getLeaveId()%>',
                                                            '<%= obj.getLeaveFrom()%>',
                                                            '<%= obj.getLeaveTo()%>',
                                                            '<%= obj.getLeaveType()%>',
                                                            '<%= obj.getReason()%>'
                                                            )">

                                        Edit

                                    </button>


                                    <!-- DELETE BUTTON -->
                                    <a href="traineesController?actionType=deleteLeave&leaveId=<%= obj.getLeaveId()%>"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Are you sure you want to delete this leave?')">

                                        Delete

                                    </a>


                                    <%

                                    } else {

                                    %>


                                    <span style="color:#cbd5e1;">
                                        Approved
                                    </span>


                                    <%                                        }

                                    %>

                                </td>

                            </tr>


                            <%                                    }

                                }

                            %>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>

    </section>

</div>


<!-- FOOTER -->
<jsp:include page="../../footer.jsp"/>


<!-- EDIT LEAVE MODAL -->
<div class="modal fade"
     id="editLeaveModal"
     tabindex="-1"
     role="dialog">

    <div class="modal-dialog"
         role="document">

        <div class="modal-content">


            <form action="traineesController"
                  method="post">


                <input type="hidden"
                       name="actionType"
                       value="updateLeave">


                <input type="hidden"
                       id="editLeaveId"
                       name="leaveId">


                <!-- MODAL HEADER -->
                <div class="modal-header">

                    <h4 class="modal-title">
                        Edit Leave
                    </h4>


                    <button type="button"
                            class="close"
                            data-dismiss="modal">

                        &times;

                    </button>

                </div>


                <!-- MODAL BODY -->
                <div class="modal-body">


                    <!-- LEAVE FROM -->
                    <div class="form-group">

                        <label>
                            Leave From
                        </label>


                        <input type="date"
                               id="editLeaveFrom"
                               name="leaveFrom"
                               class="form-control"
                               required>

                    </div>


                    <!-- LEAVE TO -->
                    <div class="form-group">

                        <label>
                            Leave To
                        </label>


                        <input type="date"
                               id="editLeaveTo"
                               name="leaveTo"
                               class="form-control"
                               required>

                    </div>


                    <!-- LEAVE TYPE -->
                    <div class="form-group">

                        <label>
                            Leave Type
                        </label>


                        <select id="editLeaveType"
                                name="leaveType"
                                class="form-control">

                            <option>
                                Casual Leave
                            </option>

                            <option>
                                Special Leave
                            </option>

                            <option>
                                Medical Leave
                            </option>

                            <option>
                                EOL
                            </option>

                        </select>

                    </div>


                    <!-- REASON -->
                    <div class="form-group">

                        <label>
                            Reason
                        </label>


                        <textarea id="editReason"
                                  name="reason"
                                  class="form-control"
                                  rows="3"
                                  required></textarea>

                    </div>

                </div>


                <!-- MODAL FOOTER -->
                <div class="modal-footer">


                    <button type="submit"
                            class="btn btn-success">

                        Update

                    </button>


                    <button type="button"
                            class="btn btn-secondary"
                            data-dismiss="modal">

                        Close

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>


<script>

    /*
     * Set minimum date for Leave From
     */
    window.onload = function () {

        var today =
                new Date()
                .toISOString()
                .split("T")[0];


        var fromDates =
                document.getElementsByClassName("fromDate");


        for (var i = 0;
                i < fromDates.length;
                i++) {

            fromDates[i].min = today;

        }

    };


    /*
     * Add New Leave Row
     */
    function addRow() {

        var tbody =
                document.getElementById("leaveTbody");


        /*
         * Clone the first row
         */
        var row =
                tbody.rows[0].cloneNode(true);


        /*
         * Clear all input values
         */
        var inputs =
                row.getElementsByTagName("input");


        for (var i = 0;
                i < inputs.length;
                i++) {

            inputs[i].value = "";

        }


        /*
         * Reset select values
         */
        var selects =
                row.getElementsByTagName("select");


        for (var i = 0;
                i < selects.length;
                i++) {

            selects[i].selectedIndex = 0;

        }


        /*
         * Set minimum date
         */
        var today =
                new Date()
                .toISOString()
                .split("T")[0];


        row.querySelector(".fromDate").min =
                today;


        row.querySelector(".toDate").min =
                today;


        /*
         * Append new row
         */
        tbody.appendChild(row);

    }


    /*
     * Remove Leave Row
     */
    function removeRow(btn) {

        var tbody =
                document.getElementById("leaveTbody");


        /*
         * At least one row must remain
         */
        if (tbody.rows.length > 1) {

            btn.closest("tr").remove();

        } else {

            alert(
                    "At least one row is required."
                    );

        }

    }


    /*
     * Date Change Event
     */
    document.addEventListener(
            "change",
            function (e) {


                /*
                 * When Leave From changes
                 */
                if (e.target.classList.contains("fromDate")) {


                    var row =
                            e.target.closest("tr");


                    var leaveTo =
                            row.querySelector(".toDate");


                    /*
                     * Leave To cannot be before Leave From
                     */
                    leaveTo.min =
                            e.target.value;

                }


                /*
                 * Calculate Total Leave Days
                 */
                if (e.target.classList.contains("fromDate")
                        || e.target.classList.contains("toDate")) {


                    var row =
                            e.target.closest("tr");


                    var from =
                            row.querySelector(".fromDate").value;


                    var to =
                            row.querySelector(".toDate").value;


                    if (from != "" && to != "") {


                        var d1 =
                                new Date(from);


                        var d2 =
                                new Date(to);


                        /*
                         * Validate date range
                         */
                        if (d2 < d1) {


                            alert(
                                    "Leave To cannot be before Leave From"
                                    );


                            row.querySelector(
                                    ".toDate"
                                    ).value = "";


                            row.querySelector(
                                    ".totalDays"
                                    ).value = "";


                            return;

                        }


                        /*
                         * Calculate total days
                         *
                         * Difference between dates
                         * + 1 to include both dates
                         */
                        var diff =
                                ((d2 - d1)
                                        / (1000 * 60 * 60 * 24))
                                        + 1;


                                row.querySelector(
                                        ".totalDays"
                                        ).value = diff;

                            }

                        }

                    }
                    );


            /*
             * Edit Leave
             *
             * Values are passed from JSP
             * to JavaScript.
             */
            function editLeave(
                    leaveId,
                    leaveFrom,
                    leaveTo,
                    leaveType,
                    reason) {


                /*
                 * Leave ID
                 */
                document.getElementById(
                        "editLeaveId"
                        ).value =
                        leaveId;


                /*
                 * Leave From
                 */
                document.getElementById(
                        "editLeaveFrom"
                        ).value =
                        leaveFrom;


                /*
                 * Leave To
                 */
                document.getElementById(
                        "editLeaveTo"
                        ).value =
                        leaveTo;


                /*
                 * Leave Type
                 */
                document.getElementById(
                        "editLeaveType"
                        ).value =
                        leaveType;


                /*
                 * Reason
                 */
                document.getElementById(
                        "editReason"
                        ).value =
                        reason;

            }

</script>