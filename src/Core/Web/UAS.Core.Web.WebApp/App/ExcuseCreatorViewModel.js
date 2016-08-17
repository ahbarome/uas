var SEPARATOR = "|";
var EMTPY_STRING = "";

$(document).ready(function () {

    var uploader = Dropzone.options.myAwesomeDropzone = {
        url: "SaveExcuse",
        method: "POST",
        uploadMultiple: true,
        autoProcessQueue: false,
        parallelUploads: 100,
        maxFiles: 100,
        paramName: "Files",
        addRemoveLinks: true,
        dictRemoveFile: 'X (Remover)',
        sending: function (file, xhr, formData) {
            var classificationChain = $("select[name='IdClassification']").val();
            var classificationId = GetValue(classificationChain, 0);
            formData.append("Justification", $("textarea[name='Justification']").val());
            formData.append("Observation", $("textarea[name='Observation']").val());
            formData.append("IdClassification", classificationId);
            formData.append("NonAttendanceIds", GetSelectedRowsId());
            formData.append("Files", file);
        },
        success: function () {
            var self = $(this);
            RefreshGrid();
            CleanForms();
            $("#modal-excuse-creator").modal("hide");
            toastr.success('Se creó la excusa de manera satisfactoria', 'UAS+');
        },
        complete: function (file) {
            this.removeFile(file);
        }
    };

    var labels = {
        cancel: "Cancelar",
        finish: "Guardar",
        next: "Siguiente",
        previous: "Anterior"
    };

    $("#wizard").steps({
        labels: labels,
        bodyTag: "fieldset",
        onStepChanging: function (event, currentIndex, newIndex) {
            // Always allow going backward even if the current step contains invalid fields!
            if (currentIndex > newIndex) {
                return true;
            }
            return true;
        },
        onStepChanged: function (event, currentIndex, priorIndex) {
            // Suppress (skip) "Warning" step if the user is old enough and wants to the previous step.
            if (currentIndex === 2 && priorIndex === 3) {
                $(this).steps("previous");
            }
        },
        onFinishing: function (event, currentIndex) {
            return true;
        },
        onFinished: function (event, currentIndex) {
            $('#my-awesome-dropzone').get(0).dropzone.processQueue();
        },
        onCanceled: function (event, currentIndex) {
            CleanForms();
            $("#modal-excuse-creator").modal("hide");
        }
    });

    CreateGrid();

    $("#btn-create-excuse").click(function () {
        var hasSelectedRows = SelectedRowsValidator();
        if (hasSelectedRows) {
            GetSelectedRowsId();
            $("#modal-excuse-creator").modal("show");
        }
        else {
            toastr.error(
                'Por favor seleccione al menos un registro para realizar la creación de la excusa', 'UAS+');
        }
    });

    OnChangeClassification();
});

function SelectedRowsValidator() {
    var hasCheckedRows = 0;
    var grid = $('#grid-pending-excuse').DataTable();

    grid.rows().every(function (index) {
        var node = grid.row(index).node();
        var hasChecked = $(node).find(".icheckbox_square-green.checked");
        if (hasChecked.length > 0) {
            hasCheckedRows++;
        }
    });
    return hasCheckedRows > 0;
};


function GetSelectedRowsId() {
    var rowsId = []
    var grid = $('#grid-pending-excuse').DataTable();

    grid.rows().every(function (index) {
        var node = grid.row(index).node();

        var hasChecked = $(node).find(".icheckbox_square-green.checked");
        if (hasChecked.length > 0) {
            var data = grid.row(index).data();
            var nonAttendanceId = data[1];
            rowsId.push(nonAttendanceId);
        }
    });

    return rowsId;
};

function CleanForms() {
    $("#form-basic-information").trigger("reset");
    $("#my-awesome-dropzone").trigger("reset");
};

function CreateGrid() {
    TurnOnICheck();

    $('#grid-pending-excuse').DataTable({
        dom: '<"html5buttons"B>lTfgitp',
        language: {
            url: '/Scripts/plugins/datatables/plugins/i18n/Spanish.txt'
        },
        "processing": true,
        buttons: [
            { extend: 'copy', text: '<span>Copiar</span>', titleAttr: 'Copiar', },
            { extend: 'csv', title: 'Ausentismo' },
            { extend: 'excel', title: 'Ausentismo' },
            { extend: 'pdf', title: 'Ausentismo' },
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

function TurnOnICheck() {
    $('input[type=checkbox]').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
    });
};

function DestroyGrid() {
    var grid = $("#grid-pending-excuse").DataTable();
    if (grid) {
        grid.destroy();
    }
};

function RefreshGrid() {
    DestroyGrid();
    InitPendingExcuseGrid();
};

function InitPendingExcuseGrid() {
    $.post("PendingExcuseGrid").done(function (response) {
        $("#grid-pending-excuse").html(response);
        CreateGrid();
    });
};

function OnChangeClassification() {
    $('select[name="IdClassification"').change(function () {
        var self = $(this);
        var requiredObservation = GetValue(self.val(), 1);
        if (requiredObservation.toUpperCase() == "TRUE") {
            $('textarea[name="Observation"').parent().attr("style", "display: block;");
        }
        else {
            $('textarea[name="Observation"').parent().attr("style", "display: none;");
        }
    });
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