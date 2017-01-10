$(document).ready(function () {
    CreateGrid();
});

function CreateGrid() {

    var grid = $('#grid-nonattendance').DataTable({
        dom: '<"html5buttons"B>lTfgitp',
        "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Todo"]],
        language: {
            url: '/Scripts/plugins/datatables/plugins/i18n/Spanish.txt'
        },
        "processing": true,
        ajax: {
            url: 'GetDataReportNonAttendance',
            dataSrc: '',
            type: "POST",
            data: function (data) {
            }
        },
        columns: [
            { data: "DocumentNumber", className: "hidden-xs" },
            { data: "CourseName" },
            { data: "DocumentNumber", className: "hidden-xs" },
            { data: "FullName" },
            { data: "RoleAlias" },
            {
                data: "NonAttendanceDate", render: function (data, type, full, meta) {
                    return String(data).substring(0, 10);
                }
            },
            { data: "StartTime" },
            {
                data: "SpaceType", render: function (data, type, full, meta) {
                    return String().concat(full.SpaceType, " ", full.SpaceName);
                }
            },
            {
                data: "HasExcuse", render: function (data, type, full, meta) {
                    if(String(data) === "1")
                    {
                        return "Si";
                    }
                    return "No";
                }
            }
        ],
        buttons: [
            { text: '<span>Refrescar</span>', titleAttr: 'Refrescar',
                action: function (e, dt, node, config) {
                    dt.ajax.reload();
                }
            },
            { extend: 'copy', text: '<span>Copiar</span>', titleAttr: 'Copiar' },
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

                    $(win.document.body)
                        .find('table')
                        .addClass('compact')
                        .css('font-size', 'inherit');
                }
            }
        ]
    });

    // Add the row number
    grid.on('order.dt search.dt', function () {
        grid.column(0, { search: 'applied', order: 'applied' }).nodes().each(function (cell, i) {
            cell.innerHTML = i + 1;
            grid.cell(cell).invalidate('dom');
        });
    }).draw();

};