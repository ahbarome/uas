﻿var SEPARATOR = "|";
var EMTPY_STRING = "";
var APP_ALIAS = 'UAS+';

$(document).ready(function () {

    TurnOnToolTips();

    CreateApprovalsGrid();

    OnChangeStatus();

    $("#btn-create-excuse").click(function () {
        var hasSelectedRows = SelectedRowsValidator();
        if (hasSelectedRows) {
            $("#modal-approval-excuse-status-changer").modal("show");
        }
        else {
            toastr.error(
             'Por favor seleccione al menos un registro para cambiar el estado de la excusa', 'UAS+');
        }
    });

    $("#btn-update-excuse-status").click(function () {

        var excuseApprovals = GetExcuseApprovals();
        console.log(excuseApprovals);
        $.post("ApproveExcuses", { excuses: excuseApprovals }, function (response) {
            $("#modal-approval-excuse-status-changer").modal("hide");
            if (response.Success) {
                RefreshGrid();
                toastr.info(
                 'Se actualizó el estado de la excusa de manera satisfactoria', APP_ALIAS);
            }
            else {
                toastr.info(
                 'Se presentaron inconvenientes actualizando el estado de la excusa, por favor inténtelo nuevamente', APP_ALIAS);
            }
        });
    });
});

function TurnOnToolTips() {
    $('[data-toggle="tooltip"]').tooltip();
};


function TurnOnICheck() {
    $('input[type=checkbox]').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
};

function TurnOnWizard() {
    var labels = {
        cancel: "Cancelar",
        finish: "Guardar",
        next: "Siguiente",
        previous: "Anterior"
    };

    $("#wizard").steps({
        labels: labels,
        bodyTag: "fieldset",
        enableFinishButton: false,
        onStepChanging: function (event, currentIndex, newIndex) {
            if (currentIndex > newIndex) {
                return true;
            }
            return true;
        },
        onStepChanged: function (event, currentIndex, priorIndex) {
            if (currentIndex === 2 && priorIndex === 3) {
                $(this).steps("previous");
            }
        },
        onFinishing: function (event, currentIndex) {
            return true;
        },
        onFinished: function (event, currentIndex) {
        },
        onCanceled: function (event, currentIndex) {
            $("#modal-approval-excuse").modal("hide");
        }
    });
};

function CreateApprovalsGrid() {
    TurnOnICheck();

    $('#grid-approval-excuse').DataTable({
        dom: '<"html5buttons"B>lTfgitp',
        language: {
            url: '/Scripts/plugins/datatables/plugins/i18n/Spanish.txt'
        },
        "processing": true,
        buttons: [
            { extend: 'copy', text: '<span>Copiar</span>', titleAttr: 'Copiar', },
            { extend: 'csv', title: 'Excusas' },
            { extend: 'excel', title: 'Excusas' },
            { extend: 'pdf', title: 'Excusas' },
            {
                extend: 'print',
                text: '<span>Imprimir</span>',
                titleAttr: 'Imprimir',
                customize: function (win) {
                    $(win.document.body).addClass('white-bg');
                    $(win.document.body).css('font-size', '10px');

                    $(win.document.body).find('table')
                            .addClass('compact')
                            .css('font-size', 'inherit');
                }
            }
        ]
    });

    OnGridDetail();
};

function CreateAttachmentsGrid() {

    $('#grid-attachment-excuse').DataTable({
        language: {
            url: '/Scripts/plugins/datatables/plugins/i18n/Spanish.txt'
        },
        "processing": true
    });
};

function OnChangeStatus() {
    $('select[name="IdStatusApproval"').change(function () {
        var self = $(this);
        var id = GetValue(self.val(), 0);
        var isLast = GetValue(self.val(), 1);
        console.log(isLast);
        console.log(id);
        if (isLast.toUpperCase() == "TRUE" && id != 3) {
            $('textarea[name="ObservationApproval"').parent().attr("style", "display: none;");
        }
        else {
            $('textarea[name="ObservationApproval"').parent().attr("style", "display: block;");
        }
    });
};

function OnGridDetail() {
    $('#grid-approval-excuse tbody').on('click', ':button[name="ExcuseDetail"]', function (e) {
        var self = $(this);
        var id = self.attr("id");
        $.post("ApprovalExcuseDetail", { IdExcuse: id }).done(function (response) {
            $("#modal-approval-excuse").html($(response).children());
            TurnOnWizard();
            CreateAttachmentsGrid();
            TurnOnToolTips();
            $("#wizard > div.content.clearfix").attr("style", "background-color: #FFFFFF");
            $("#modal-approval-excuse").modal("show");
        });
    });
};

function SelectedRowsValidator() {
    var hasCheckedRows = 0;
    var grid = $('#grid-approval-excuse').DataTable();

    grid.rows().every(function (index) {
        var node = grid.row(index).node();
        var hasChecked = $(node).find(".icheckbox_square-green.checked");
        if (hasChecked.length > 0) {
            hasCheckedRows++;
        }
    });
    return hasCheckedRows > 0;
};

function GetValue(chain, index) {
    var fields = chain.split(SEPARATOR);
    try {
        if (fields.length > 0) {
            return fields[index];
        }
        else {
            return EMPTY_STRING;
        }
    }
    catch (err) {
        return EMPTY_STRING;
    }
};

function GetExcuseApprovalsSelectedRowsData() {
    var rowsData = []
    var grid = $('#grid-approval-excuse').DataTable();

    grid.rows().every(function (index) {
        var node = grid.row(index).node();

        var hasChecked = $(node).find(".icheckbox_square-green.checked");
        if (hasChecked.length > 0) {
            var data = grid.row(index).data();
            var id = data[1];
            var idExcuse = data[2];
            var idNonAttendance = data[3];
            var idApproverRole = data[4];
            rowsData.push({
                "Id": id,
                "IdExcuse": idExcuse,
                "IdNonAttendance": idNonAttendance,
                "IdRoleApprover": idApproverRole
            });
        }
    });

    return rowsData;
};

function GetExcuseApprovals() {

    var excuseApprovals = [];
    var approvals = GetExcuseApprovalsSelectedRowsData();
    var idStatusApproval = GetStatusApproval();
    var observationApproval = GetObservationApproval();

    $.each(approvals, function (index, approval) {
        excuseApprovals.push(
            {
                "Id": parseInt(approval.Id),
                "IdExcuse": approval.IdExcuse,
                "IdRoleApprover": approval.IdRoleApprover,
                "IdNonAttendance": approval.IdNonAttendance,
                "IdStatusApproval": idStatusApproval,
                "ObservationApproval": observationApproval
            });
    });

    return excuseApprovals;
};


function GetStatusApproval() {
    var statusApproval = $('select[name="IdStatusApproval"]').val();
    var idStatusApproval = GetValue(statusApproval, 0);
    return parseInt(idStatusApproval);
};

function GetObservationApproval() {
    var observationApproval = $('textarea[name="ObservationApproval"]').val();
    return observationApproval;
};

function DestroyGrid() {
    var grid = $("#grid-approval-excuse").DataTable();
    if (grid) {
        grid.destroy();
    }
};

function RefreshGrid() {
    DestroyGrid();
    InitPendingExcuseGrid();
};

function InitPendingExcuseGrid() {
    $.post("ApprovalExcuseGrid").done(function (response) {
        $("#grid-approval-excuse").html(response);
        CreateApprovalsGrid();
    });
};