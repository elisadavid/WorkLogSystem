<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.staffDetails"%>
<%@page import="model.traineeDetails"%>

<%
    ArrayList<staffDetails> arrStaff
            = (ArrayList<staffDetails>) request.getAttribute("arrStaff");

    ArrayList<traineeDetails> arrTrainee
            = (ArrayList<traineeDetails>) request.getAttribute("arrTrainee");
%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="headSidemenu.jsp"/>

<div class="content-wrapper">

    <section class="content-header">
        <div class="container-fluid">
            <h1>Assign Mentor</h1>
        </div>
    </section>

    <section class="content">

        <div class="container-fluid">

            <div class="card card-primary card-outline">

                <div class="card-header">
                    <h3 class="card-title">
                        Assign Mentor to Trainee
                    </h3>
                </div>

                <form action="HeadController?actionType=saveMentor" method="post">

                    <div class="card-body">

                        <!-- Trainee -->

                        <div class="form-group">

                            <label>Select Trainee</label>

                            <select name="traineeId"
                                    class="form-control"
                                    required>

                                <option value="">
                                    -- Select Trainee --
                                </option>

                                <%
                                    if (arrTrainee != null) {

                                        for (traineeDetails trainee : arrTrainee) {
                                %>

                                <option value="<%=trainee.getTraineeId()%>">

                                    <%=trainee.getTraineeId()%> -
                                    <%=trainee.getTraineeName()%>

                                </option>

                                <%
                                        }
                                    }
                                %>

                            </select>

                        </div>

                        <!-- Mentor -->

                        <div class="form-group">
                            <label>Select Mentor</label>
                            <select name="staffId" class="form-control"  >

                                <option value="">  -- Select Mentor -- </option>

                                <%
                                    if (arrStaff != null) {
                                        for (staffDetails staff : arrStaff) {
                                %>
                                <option value="<%=staff.getStaffId()%>">
                                    <%=staff.getStaffId()%> - <%=staff.getStaffName()%> </option>

                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="card-footer">
                        <button type="submit"  class="btn btn-primary"><i class="fas fa-user-check"></i>  Assign Mentor</button>
                        <button type="reset"  class="btn btn-secondary">    Reset </button>
                    </div>
                </form>
            </div>
        </div>
    </section>
</div>

<jsp:include page="../../footer.jsp"/>