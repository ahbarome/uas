
$(document).ready(function () {

    $(window).keydown(function (event) {
        if (event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });

    $("#form-login").validate({
        rules: {
            Username: {
                required: true
            },
            Password: {
                required: true
            }
        },
        messages: {
            Username: {
                required: "El nombre de usuario es requerido"
            },
            Password: {
                required: "El password es requerido"
            }
        }
    });

    $("#btn-submit").click(function () {
        var $current_form = $("#form-login");
        if ($current_form.valid()) {
            
            $.ajax({
                url: "/Account/Login",
                type: "POST",
                data: $current_form.serialize(),
                success: function (response) {
                    if (response.success) {
                        window.location = response.url;
                    }
                    else {
                        toastr.error(response.message, 'UAS+');
                    }
                },
                error: function (response) {
                    toastr.error(response.message, 'UAS+');
                }
            });
        }
    });

});