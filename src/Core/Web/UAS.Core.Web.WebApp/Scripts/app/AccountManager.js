
$(document).ready(function () {

    function onErrorShake() {
        $('#login-container').removeClass('fadeInDown');
        $('#login-container').addClass('wobble');
    };

    $("#form-login").validate({
        rules: {
            Username:{
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
            $(this).addClass('active');
            $.ajax({
                url: "/Account/Login",
                type: "POST",
                data: $current_form.serialize(),
                success: function (response) {
                    if (response.success) {
                        window.location.href = response.url;
                    }
                    else {
                        toastr.error(response.message, 'UAS+');
                    }
                },
                error: function (response) {
                    toastr.error(response.message, 'UAS+');
                }
            }).done(function () {
                $(this).removeClass('active');
            });
        }
        else {
            onErrorShake();
        }
    }); 

});