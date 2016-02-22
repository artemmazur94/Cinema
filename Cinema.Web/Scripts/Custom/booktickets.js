$(document).ready(function() {
    $(".seat").click(function() {
        $.ajax({
            url: window.myActionUrl,
            type: 'POST',
            data: {
                'row': '1',
                'place': '2',
                'seanceId': seanceId
            },
            accept: 'application/json',
            success: function(data) {
                if (data) {

                }
            }
        });
    });

    var expiresTime = new Date();
    expiresTime.setMinutes(expiresTime.getMinutes() + 15);

    $('#clock').countdown(expiresTime)
        .on('update.countdown', function (event) {
            var format = '%M:%S';
            $(this).html(event.strftime(format));
        }).on('finish.countdown', function() {
            $(this).html('This offer has expired!')
                .parent().addClass('disabled');
        });
});
