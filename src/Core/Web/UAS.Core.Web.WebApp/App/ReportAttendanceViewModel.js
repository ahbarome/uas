$(document).ready(function () {
    CreateGrid();
});

function CreateGrid() {

    var grid = $('#grid-attendance').DataTable({
        dom: '<"html5buttons"B>lTfgitp',
        "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Todo"]],
        language: {
            url: '/Scripts/plugins/datatables/plugins/i18n/Spanish.txt'
        },
        "processing": true,
        buttons: [
            { extend: 'copy', text: '<span>Copiar</span>', titleAttr: 'Copiar', },
            { extend: 'csv', title: 'Asistencia' },
            { extend: 'excel', title: 'Asistencia' },
            { extend: 'pdf', title: 'Asistencia' },
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

    // Add the row number
    grid.on('order.dt search.dt', function () {
        grid.column(0, { search: 'applied', order: 'applied' }).nodes().each(function (cell, i) {
            cell.innerHTML = i + 1;
            grid.cell(cell).invalidate('dom');
        });
    }).draw();
};