<%--
    Document   : footer
    Production Version
--%>

<aside class="control-sidebar control-sidebar-dark"></aside>

</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>

<!-- jQuery UI -->
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>

<script>
    $.widget.bridge('uibutton', $.ui.button);
</script>

<!-- Bootstrap -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- SweetAlert2 -->
<script src="plugins/sweetalert2/sweetalert2.min.js"></script>

<!-- Toastr -->
<script src="plugins/toastr/toastr.min.js"></script>

<!-- DataTables -->
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>

<!-- Select2 -->
<script src="plugins/select2/js/select2.full.min.js"></script>

<!-- Chart.js -->
<script src="plugins/chart.js/Chart.min.js"></script>

<!-- Moment -->
<script src="plugins/moment/moment.min.js"></script>

<!-- Date Range Picker -->
<script src="plugins/daterangepicker/daterangepicker.js"></script>

<!-- Tempus Dominus -->
<script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>

<!-- Overlay Scrollbars -->
<script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>

<!-- Bootstrap Switch -->
<script src="plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>

<!-- BS Custom File Input -->
<script src="plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>

<!-- AdminLTE -->
<script src="dist/js/adminlte.min.js"></script>

<script>
$(function () {

    // Initialize Bootstrap Switch safely
    if ($.fn.bootstrapSwitch) {
        $("input[data-bootstrap-switch]").each(function () {
            $(this).bootstrapSwitch('state', $(this).prop('checked'));
        });
    }

    // Initialize Select2 safely
    if ($.fn.select2) {
        $('.select2').select2();
    }

    // Initialize File Input safely
    if (typeof bsCustomFileInput !== "undefined") {
        bsCustomFileInput.init();
    }

    // Initialize DataTables safely
    if ($.fn.DataTable) {
        $('.datatable').DataTable({
            responsive: true,
            autoWidth: false
        });
    }

});
</script>

</body>
</html>