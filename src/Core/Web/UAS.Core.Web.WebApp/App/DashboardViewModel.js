var UNDEFINED = 'undefined';

$(document).ready(function () {
    $.post("/Home/GetStatistictsAttendanceVsNonAttendance", function (attendanceVsNonAttendanceData) {
        PopulateGraphStatistictsAttendanceVsNonAttendance(attendanceVsNonAttendanceData);
    });
});

function IsValidData(data) {
    var isValid = false;
    if (Object.keys(data).length > 0) {
        isValid = true;
    }
    return isValid;
};

function PopulateGraphStatistictsAttendanceVsNonAttendance(attendanceVsNonAttendanceData) {
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
                    data: attendanceData
                },
                {
                    fillColor: "rgba(26,179,148,0.5)",
                    strokeColor: "rgba(26,179,148,0.7)",
                    pointColor: "rgba(26,179,148,1)",
                    pointStrokeColor: "#fff",
                    pointHighlightFill: "#fff",
                    pointHighlightStroke: "rgba(26,179,148,1)",
                    data: nonAttendanceData
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

        var ctx = document.getElementById("graphAttendanceVsNonAttendance").getContext("2d");
        var myNewChart = new Chart(ctx).Line(lineData, lineOptions);
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
}

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