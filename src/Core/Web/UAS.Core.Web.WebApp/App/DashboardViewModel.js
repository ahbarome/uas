var UNDEFINED = 'undefined';

$(document).ready(function () {
    $.post("/Home/GetStatistictsAttendanceVsNonAttendance", function (attendanceVsNonAttendanceData) {
        PopulateGraphLinearStatistictsAttendanceVsNonAttendance(attendanceVsNonAttendanceData);
        PopulateGraphDonutStatistictsAttendanceVsNonAttendance(attendanceVsNonAttendanceData);
    });
});

function IsValidData(data) {
    var isValid = false;
    if (Object.keys(data).length > 0) {
        isValid = true;
    }
    return isValid;
};

function PopulateGraphLinearStatistictsAttendanceVsNonAttendance(attendanceVsNonAttendanceData) {
    if (IsValidData(attendanceVsNonAttendanceData)) {
        
        var attendanceData = GetGraphStatistictsAttendanceData(attendanceVsNonAttendanceData);
        var nonAttendanceData = GetGraphStatistictsNonAttendanceData(attendanceVsNonAttendanceData);
        var labelsAttendanceVsNonAttendance = GetLabelsGraphStatistictsAttendanceVsNonAttendance(attendanceVsNonAttendanceData);
        
        var lineData = {
            labels: labelsAttendanceVsNonAttendance,
            datasets: [
                {
                    fillColor: "rgba(220,220,220,0.5)",
                    strokeColor: "rgba(220,220,220,1)",
                    pointColor: "rgba(220,220,220,1)",
                    pointStrokeColor: "#fff",
                    pointHighlightFill: "#fff",
                    pointHighlightStroke: "rgba(220,220,220,1)",
                    data: nonAttendanceData
                },
                {
                    fillColor: "rgba(26,179,148,0.5)",
                    strokeColor: "rgba(26,179,148,0.7)",
                    pointColor: "rgba(26,179,148,1)",
                    pointStrokeColor: "#fff",
                    pointHighlightFill: "#fff",
                    pointHighlightStroke: "rgba(26,179,148,1)",
                    data: attendanceData
                }
            ]
        };

        var lineOptions = {
            scaleShowGridLines: true,
            scaleGridLineColor: "rgba(0,0,0,.05)",
            scaleGridLineWidth: 1,
            bezierCurve: true,
            bezierCurveTension: 0.4,
            pointDot: true,
            pointDotRadius: 4,
            pointDotStrokeWidth: 1,
            pointHitDetectionRadius: 20,
            datasetStroke: true,
            datasetStrokeWidth: 2,
            datasetFill: true,
            responsive: true,
        };

        var contextLinear = document.getElementById("graphLinearAttendanceVsNonAttendance").getContext("2d");
        var linearChart = new Chart(contextLinear).Line(lineData, lineOptions);


        var contextRadar = document.getElementById("graphRadarAttendanceVsNonAttendance").getContext("2d");
        var radarChart = new Chart(contextRadar).Radar(lineData, lineOptions);
        
    }
};

function PopulateGraphDonutStatistictsAttendanceVsNonAttendance(attendanceVsNonAttendanceData) {
    if (IsValidData(attendanceVsNonAttendanceData)) {

        var attendanceData = GetGraphStatistictsAttendanceData(attendanceVsNonAttendanceData);
        var nonAttendanceData = GetGraphStatistictsNonAttendanceData(attendanceVsNonAttendanceData);
        var totalAttendance = Sum(attendanceData);
        var totalNonAttendance = Sum(nonAttendanceData);
        var attendance = {
            value: totalAttendance,
            color: "#a3e1d4",
            highlight: "#1ab394",
            label: "Asistencia"
        };

        var nonAttendance = {
            value: totalNonAttendance,
            color: "#A4CEE8",
            highlight: "#1ab394",
            label: "Ausentismo"
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

        var ctx = document.getElementById("graphDonutAttendanceVsNonAttendance").getContext("2d");
        var DoughnutChart = new Chart(ctx).Doughnut(doughnutData, doughnutOptions);
    }
};

function GetLabelsGraphStatistictsAttendanceVsNonAttendance(attendanceVsNonAttendanceData) {
    var labels = [];
    $.each(attendanceVsNonAttendanceData, function (index, attendanceVsNonAttendance) {
        var description = attendanceVsNonAttendance.Description;
        if (!Contain(labels, description)) {
            labels.push(description);
        }
    });
    return labels;
};

function Contain(array, value) {
    var length = Object.keys(array).length;
    for (var i = 0; i < length; i++) {
        if (array[i] == value) {
            return true;
        }
    }
    return false;
};

function Sum(array) {
    var sum = 0;
    var length = Object.keys(array).length;
    for (var i = 0; i < length; i++) {
        sum += array[i];
    }
    return sum;
};

function GetGraphStatistictsAttendanceData(attendanceVsNonAttendanceData) {
    var data = [];
    $.each(attendanceVsNonAttendanceData, function (index, attendanceVsNonAttendance) {
        var attendance = attendanceVsNonAttendance.Summary.Attendance;
        if (typeof (attendance) !== UNDEFINED) {
            data.push(attendance);
        }
    });
    return data;
};

function GetGraphStatistictsNonAttendanceData(attendanceVsNonAttendanceData) {
    var data = [];
    $.each(attendanceVsNonAttendanceData, function (index, attendanceVsNonAttendance) {
        var nonAttendance = attendanceVsNonAttendance.Summary.NonAttendance;
        if (typeof (nonAttendance) !== UNDEFINED) {
            data.push(nonAttendance);
        }
    });
    return data;
};