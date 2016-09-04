var SEPARATOR = "|";
var EMTPY_STRING = "";
var APP_ALIAS = 'UAS+';

$(document).ready(function () {

    TurnOnToolTips();

    CreateVerificatorGrid();

});

function TurnOnToolTips() {
    $('[data-toggle="tooltip"]').tooltip();
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
            $("#modal-verificator-excuse").modal("hide");
        }
    });
};

function CreateVerificatorGrid() {

    $('#grid-verificator-excuse').DataTable({
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

function CreateApprovalsGrid() {

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
};

function CreateAttachmentsGrid() {

    $('#grid-attachment-excuse').DataTable({
        language: {
            url: '/Scripts/plugins/datatables/plugins/i18n/Spanish.txt'
        },
        "processing": true
    });
};

function CreateApprovalExcusesGrid() {
    $("#grid-approvals-excuse").DataTable({
        language: {
            url: '/Scripts/plugins/datatables/plugins/i18n/Spanish.txt'
        },
        "processing": true
    });
};

function OnGridDetail() {
    $('#grid-verificator-excuse tbody').on('click', ':button[name="ExcuseDetail"]', function (e) {
        var self = $(this);
        var id = self.attr("id");
        $.post("ExcuseVerificatorDetail", { idExcuse: id }).done(function (response) {
            $("#modal-verificator-excuse").html($(response).children());
            TurnOnWizard();
            CreateAttachmentsGrid();
            CreateApprovalsGrid();
            CreateApprovalExcusesGrid();
            TurnOnToolTips();
            $("#wizard > div.content.clearfix").attr("style", "background-color: #FFFFFF");
            $("#modal-verificator-excuse").modal("show");
        });
    });
};

function DestroyGrid() {
    var grid = $("#grid-verificator-excuse").DataTable();
    if (grid) {
        grid.destroy();
    }
};

function RefreshGrid() {
    DestroyGrid();
    InitPendingExcuseGrid();
};

function InitPendingExcuseGrid() {
    $.post("ExcuseVerificatorGrid").done(function (response) {
        $("#grid-verificator-excuse").html(response);
        CreateVerificatorGrid();
    });
};