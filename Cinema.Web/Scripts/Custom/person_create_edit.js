$(document).ready(function() {
    $("#submit-btn").click(function() {
        if (validateInputs()) {
            $("#person-create-edit-form").submit();
        }
    });

    $("#Name").focus(function() {
        $("#Name").parent().removeClass("has-error");
        $("#name-label").addClass("hidden");
    });
});

function validateInputs() {
    if ($("#Name").val().length >= 1 && !validateTrim($("#Name").val())) {
        return true;
    }
    $("#Name").parent().addClass("has-error");
    $("#name-label").removeClass("hidden");
    return false;
}