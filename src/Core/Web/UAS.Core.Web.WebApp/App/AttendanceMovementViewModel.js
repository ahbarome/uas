var AttendanceMovementViewModel = function () {
    var self = this;
    self.movements = ko.observableArray();
    self.loading = ko.observable(true);

    $.post("GetMovements", function (data) {
        self.movements(data);
    });
};

var signalRHubInitialized = false;

$(function () {
    InitializeKnockOutViewModel();
    InitializeSignalRHubStore();
    InitializeGraphs();
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
            if (message === "Refresh") {
                ReloadIndexPartial();
            }
        };

        setInterval(function () {
            var message = "New message";
            toastr.info(message, 'UAS+');
            movementsHub.server.broadcastMessages("New message");
        }, 5000);

        $.movementsHub.hub.start().done(function () {
            signalRHubInitialized = true;
        });
    }
    catch (err) {
        signalRHubInitialized = false;
    }
};

function ReloadIndexPartial() {
    console.log("ReloadIndexPartial");
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