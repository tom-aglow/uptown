$(function () {
    let barbersImages = $('.barbers__img__cont');
    let barbersNames = $('.barbers__names span');
    let timeBoxes = $('.times .time');

    //  CLICK EVENT ON BARBER IMAGE & BARBER NAME
    barbersImages.click(function () {
        let index = barbersImages.index($(this));
        selectBarber(index);
    });

    barbersNames.click(function () {
        let index = barbersNames.index($(this));
        selectBarber(index);
    });

    //  EVENTS WHEN SERVICES SELECT BOX CHANGES ITS VALUE > UPDATE VALUES IN CORRESPONDENT FORM INPUT
    $('#select-service').change(function () {
        $('#requisition_service_id').val($(this).val());
    });

    //  DATEPICKER
    let dateInput = $('#datepicker')
    dateInput.datepicker({
        format: 'yyyy-mm-dd',
        orientation: 'left bottom',
        startDate: new Date(),
        todayHighlight: true,
        datesDisabled: '2017-09-05'
    });

    dateInput.datepicker().on('changeDate', function () {
        $('#shift_date').val(formatDate(dateInput.datepicker('getDate')));
    });

    //  CLICK EVENT ON TIME ELEMENT
    timeBoxes.click(function () {
        let $this = $(this);

        //  change value of corresponding input field
        $('#shift_time').val($this.data('time'));

        //  remove active class from all elements
        timeBoxes.removeClass('active');

        //  add active class only for target element
        $this.addClass('active');
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

    function formatDate (date) {
        let d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }
});