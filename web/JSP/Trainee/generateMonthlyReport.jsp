<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="traineeSideMenu.jsp"/>

<div class="content-wrapper">

    <section class="content-header">
        <div class="container-fluid">
            <h3>Generate Monthly Report</h3>
        </div>
    </section>

    <section class="content">

        <div class="container-fluid">

            <div class="card card-primary">

                <div class="card-header">
                    <h3 class="card-title">Select Month</h3>
                </div>

                <form action="traineesController" method="post">

                    <input type="hidden" name="actionType" value="createMonthlyReport">

                    <div class="card-body">

                        <div class="row">

                            <div class="col-md-6">

                                <div class="form-group">
                                    <label>Month</label>

                                    <select name="month" class="form-control" required>

                                        <option value="">--Select Month--</option>

                                        <option value="1">January</option>
                                        <option value="2">February</option>
                                        <option value="3">March</option>
                                        <option value="4">April</option>
                                        <option value="5">May</option>
                                        <option value="6">June</option>
                                        <option value="7">July</option>
                                        <option value="8">August</option>
                                        <option value="9">September</option>
                                        <option value="10">October</option>
                                        <option value="11">November</option>
                                        <option value="12">December</option>

                                    </select>

                                </div>

                            </div>

                            <div class="col-md-6">

                                <div class="form-group">

                                    <label>Year</label>

                                    <select name="year" class="form-control" required>

                                        <%
                                            int currentYear = java.time.Year.now().getValue();

                                            for (int i = currentYear; i >= currentYear - 5; i--) {
                                        %>

                                        <option value="<%=i%>"><%=i%></option>

                                        <%
                                            }
                                        %>

                                    </select>

                                </div>

                            </div>

                        </div>

                    </div>

                    <div class="card-footer">

                        <button type="submit" class="btn btn-primary">
                            Generate Report
                        </button>

                    </div>

                </form>

            </div>

        </div>

    </section>

</div>

<jsp:include page="../../footer.jsp"/>