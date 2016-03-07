$(document).ready(function() {
    $("#submit-btn").click(function() {
        if (validateInputs()) {
            $("#restore-password-form").submit();
        }
    });

    $("#Email").focus(function () {
        $(this).parent().removeClass("has-error");
        $("#email-label").addClass("hidden");
    });
});

function validateInputs() {
    if (validateEmail($("#Email").val())) {
        return true;
    }
    $("#Email").parent().addClass("has-error");
    $("#email-label").removeClass("hidden");
    return false;
}

function validateEmail(email) {
    var emailReg = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
    return emailReg.test(email);
}