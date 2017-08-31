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