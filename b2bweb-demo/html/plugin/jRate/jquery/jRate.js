$(document).ready(function() {
    $('.basic').jRating();

    $('.exemple2').jRating({
        type: 'small',
        length: 40,
        decimalLength: 1
    });

    $('.exemple3').jRating({
        step: true,
        length: 20
    });

    $('.exemple4').jRating({
        isDisabled: true
    });

    $('.exemple5').jRating({
        length: 10,
        decimalLength: 1,
        onSuccess: function() {
            alert('Success : your rate has been saved :)');
        },
        onError: function() {
            alert('Error : please retry');
        }
    });

    $(".exemple6").jRating({
        length: 10,
        decimalLength: 1,
        showRateInfo: false
    });
});