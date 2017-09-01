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

        //  AJAX

        $.ajax({
            url: "/booking_info",
            type: "GET",
            format: "json",
            data: { barber_id: index + 1 },
            complete: function () {},
            success: function (data, textStatus, xhr) {
                let shifts = getFormattedData(data.shifts);
                console.log(shifts);
                setAvailableDates(shifts);
            },
            error: function () {
                console.log('Ajax error!');
            }
        });
    });

    //  EVENTS WHEN SERVICES SELECT BOX CHANGES ITS VALUE > UPDATE VALUES IN CORRESPONDENT FORM INPUT
    $('#select-service').change(function () {
        $('#requisition_service_id').val($(this).val());
    });

    //  DATEPICKER
    let dateInput = $('#datepicker');

    dateInput.datepicker({
        format: 'yyyy-mm-dd',
        orientation: 'left bottom',
        startDate: new Date(),
        todayHighlight: true,
        autoclose: true
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

    //  === highlight selected barber
    function selectBarber (index) {
        $('#shift_barber_id').val(index + 1);

        //  remove active class from all elements
        barbersImages.removeClass('active');
        barbersNames.removeClass('active');

        //  add active class only for target element
        barbersImages.eq(index).addClass('active');
        barbersNames.eq(index).addClass('active');
    }

    //  === format JS date object to string 'yyyy-mm-dd'
    function formatDate (date) {
        let d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }

    //  === Manage & format data from AJAX-request

    function getFormattedData (shifts) {
        let dates = {};
        for (let i = 0; i < shifts.length; i++) {
            let key = shifts[i].date;
            if (!dates[key]) {
                dates[key] = [];
            }
            dates[key].push(shifts[i].time);
        }
        return dates;
    }

    function setAvailableDates (shifts) {
        let keys = Object.keys(shifts);
        let datesAll = getDates(keys[keys.length - 1], keys[0]);
        let datesUnavailable = [];

        for (let i = 0; i < datesAll.length; i++) {
            if (keys.indexOf(datesAll[i]) === -1) {
                datesUnavailable.push(datesAll[i]);
            }
        }
        dateInput.datepicker('setDatesDisabled', datesUnavailable);
        dateInput.datepicker('setEndDate', keys[0]);
    }

    //  === all days between two dates
    function getDates(d1, d2){
        let oneDay = 24 * 3600 * 1000;
        let dStart = new Date(d1 + ' 12:00:00 GMT-0700');
        let dEnd = new Date(d2 + ' 12:00:00 GMT-0700');
        let d = [];

        for (let ms = dStart * 1, last = dEnd * 1; ms <= last; ms += oneDay){
            d.push( formatDate(new Date(ms)) );
        }
        return d;
    }
});