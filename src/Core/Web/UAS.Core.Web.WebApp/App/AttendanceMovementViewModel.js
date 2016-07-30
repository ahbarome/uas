var AttendanceMovementViewModel = function () {
    var self = this;
    self.movements = ko.observableArray();
    self.loading = ko.observable(true);
};

var signalRHubInitialized = false;

$(function () {
    InitializeKnockOutViewModel();
    InitializeSignalRHubStore();
    DonutChart();
});

function InitializeKnockOutViewModel() {
    var viewModel = new AttendanceMovementViewModel();
    ko.applyBindings(viewModel);
};

function InitializeSignalRHubStore() {

    if (signalRHubInitialized)
        return;

    try {
        $.connection.hub.logging = true;
        var movementsHub = $.connection.movementHub;

        movementsHub.client.writeMessage = function (message) {
            toastr.success(message, 'UAS+');
        };

        movementsHub.client.broadcastMessage = function (message) {
            console.log("broadcastMessage");
            if (message === "Refresh") {
                toastr.info('Nuevo movimiento', 'UAS+');
                ReloadIndexPartial();
                ReloadCourseAttendanceStatisticPartial();
                DonutChart();
            }
        };

        $.connection.hub.start().done(function () {
            movementsHub.server.initialize();
            signalRHubInitialized = true;
        });
    }
    catch (err) {
        signalRHubInitialized = false;
    }
};

function ReloadIndexPartial() {

    $.post("VirtualStudentsClassRoomPartial").done(function (response) {
        $("#attendance").html(response);
        if (!signalRHubInitialized)
            InitializeSignalRHubStore();
    });
};

function ReloadCourseAttendanceStatisticPartial() {

    $.post("CourseAttendanceStatisticPartial").done(function (response) {
        $("#course-attendance-statistic").html(response);
        if (!signalRHubInitialized)
            InitializeSignalRHubStore();
    });
};


function InitializeGraphs() {
    $("#sparkline1").sparkline([34, 43, 43, 35, 44, 32, 44, 48], {
        type: 'line',
        width: '100%',
        height: '50',
        lineColor: '#1ab394',
        fillColor: "transparent"
    });
};

function DonutChart() {

    $.post("GetStatistics").done(function (statistic) {

        var attendance = {
            value: statistic.Summary.Asistentes,
            color: "#a3e1d4",
            highlight: "#1ab394",
            label: "Asistencia"
        };

        var nonAttendance = {
            value: statistic.Summary.Inasistentes,
            color: "#A4CEE8",
            highlight: "#1ab394",
            label: "Inasistencia"
        };

        var doughnutData = [
            attendance,
            nonAttendance
        ];

        var doughnutOptions = {
            segmentShowStroke: true,
            segmentStrokeColor: "#fff",
            segmentStrokeWidth: 2,
            percentageInnerCutout: 45, // This is 0 for Pie charts
            animationSteps: 100,
            animationEasing: "easeOutBounce",
            animateRotate: true,
            animateScale: false
        };

        var ctx = document.getElementById("doughnutChart").getContext("2d");
        var DoughnutChart = new Chart(ctx).Doughnut(doughnutData, doughnutOptions);
    });
}