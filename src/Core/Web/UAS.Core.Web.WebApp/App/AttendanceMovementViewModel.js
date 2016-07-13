var AttendanceMovementViewModel = function () {
    var self = this;
    self.movements = ko.observableArray();
    self.loading = ko.observable(true);

    $.ajax({
        url: 'GetMovements',
        type: 'POST',
        success: function (data) { self.movements(data); },
        error: function (response) { }
    });
    
};

$(function () {
    $("#sparkline1").sparkline([34, 43, 43, 35, 44, 32, 44, 48], {
        type: 'line',
        width: '100%',
        height: '50',
        lineColor: '#1ab394',
        fillColor: "transparent"
    });

    var viewModel = new AttendanceMovementViewModel();

    ko.applyBindings(viewModel);

    var movementsHub = $.connection.movementHub;

    movementsHub.client.writeMessage = function (message) {
        toastr.success(message, 'UAS+');
    };

    var myVar = setInterval(function () {
        var message = "New message";
        toastr.info(message, 'UAS+');
        movementsHub.server.broadcastMessages("New message");
    }, 5000);

    $.connection.hub.start();
});
