
$(document).ready(function () {

    var uploader = Dropzone.options.myAwesomeDropzone = {
        url: "SaveExcuse",
        method: "POST",
        uploadMultiple: true,
        autoProcessQueue: false,
        parallelUploads: 10,
        maxFiles: 10,
        paramName: "Files",
        addRemoveLinks: true,
        dictRemoveFile: 'X (Remover)',
        sending: function (file, xhr, formData) {
            formData.append("Justification", $("textarea[name='Justification']").val());
            formData.append("IdClassification", $("select[name='IdClassification']").val());
            formData.append("IdNonAttendance", 1);
            formData.append("Files", file);
        },
        success: function () {
            var self = $(this);

            $("#form-basic-information").trigger("reset");
            $("#my-awesome-dropzone").trigger("reset");
            $("#modal-excuse-creator").modal("hide");
            toastr.success('Se creó la excusa de manera satisfactoria', 'UAS+');
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
            $("#modal-excuse-creator").modal("hide");
        }
    }).validate({
        errorPlacement: function (error, element) {
            element.before(error);
        },
        rules: {
            Classification: {
                required: true,
            },
            Justification: {
                required: true,
                maxlength: 50
            }
        }
    });

    function turnOnICheck() {
        $('input[type=checkbox]').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green'
        });
    };

    turnOnICheck();

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

    $('#grid-pending-excuse tbody ins').on('click', function (e) {
        toastr.info('Click', 'UAS+');
    });

    $("#btn-create-excuse").click(function () {
        var hasSelectedRows = SelectedRowsValidator();
        if (hasSelectedRows) {
            $("#modal-excuse-creator").modal("show");
        }
        else {
            toastr.error(
                'Por favor seleccione al menos un registro para realizar la creación de la excusa', 'UAS+');
        }
    });

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
            console.log(data[3]);
            //rowsId.push({ "Id": grid.row(index) });
        }
    });
    return rowsId;
};