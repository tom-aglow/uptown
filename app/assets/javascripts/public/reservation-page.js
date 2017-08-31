$(function () {
    let barbersImages = $('.barbers__img__cont');
    let barbersNames = $('.barbers__names span');

    //  CLICK EVENT ON BARBER IMAGE & BARBER NAME
    barbersImages.click(function () {
        let index = barbersImages.index($(this));
        selectBarber(index);
    });

    barbersNames.click(function () {
        let index = barbersNames.index($(this));
        selectBarber(index);
    });

    //  EVENTS WHEN STEP 2 BOXES CHANGES THEIR VALUE > UPDATE VALUES IN CORRESPONDENT FORM INPUTS
    $('#select-service').change(function () {
        $('#requisition_service_id').val($(this).val());
    });


    //  FUNCTIONS
    
    function selectBarber (index) {
        $('#shift_barber_id').val(index + 1);

        //  remove active class from all elements
        barbersImages.removeClass('active');
        barbersNames.removeClass('active');

        //  add active class only for target element
        barbersImages.eq(index).addClass('active');
        barbersNames.eq(index).addClass('active');
    }
});