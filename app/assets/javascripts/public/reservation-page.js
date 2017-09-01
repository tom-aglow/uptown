$(function () {
    let barbersImages = $('.barbers__img__cont');
    let barbersNames = $('.barbers__names span');
    let shifts = {};
    let shiftDates = [];

    //  CLICK EVENT ON BARBER IMAGE & BARBER NAME
    barbersImages.click(function () {
        let index = barbersImages.index($(this));
        selectBarber(index);
        getShiftsInfo(index + 1);
    });

    barbersNames.click(function () {
        let index = barbersNames.index($(this));
        selectBarber(index);
        getShiftsInfo(index + 1);
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
        startDate: new Date(),                  //  picker is initiated with no available dates first
        endDate: new Date(Date.now() - 864e5),
        todayHighlight: true,
        autoclose: true
    });

    dateInput.datepicker().on('changeDate', function () {
        //  change the value of input box
        let selectedDate = formatDate(dateInput.datepicker('getDate'));
        $('#shift_date').val(selectedDate);

        //  render time boxes
        let availableTimes = shifts[selectedDate];

        $('.time').remove();

        for (let i = 0; i < availableTimes.length; i++) {
            let box = $("<span class='time' data-time=" + availableTimes[i] + "></span>").text(formatAMPM(availableTimes[i]));
            $('#times').append(box);
        }

    });

    //  CLICK EVENT ON TIME ELEMENT
    $(document).on('click', '.time', function () {
        let $this = $(this);
        //  change value of corresponding input field
        $('#shift_time').val($this.data('time'));

        //  remove active class from all elements
        $('.time').removeClass('active');

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

    //  === format time from 24-hour format to 12-hour format
    function formatAMPM (time) {
        let hours = +time.split(':')[0];
        let ampm = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        hours = hours ? hours : 12; // the hour '0' should be '12'
        hours = (hours < 10) ? '0' + hours : hours;
        return hours + ':00 ' + ampm;
    }

    //  === set default date of datepicker and remove all time elements
    function setDefaultView () {
        dateInput.datepicker('update', new Date());
        $('.time').remove();
        $('#shift_date').val('');
        $('#shift_time').val('');
    }

    //  === Retrieve, format & manage data from AJAX-request

    function getShiftsInfo (barber_id) {
        $.ajax({
            url: "/booking_info",
            type: "GET",
            format: "json",
            data: { barber_id: barber_id },
            complete: function () {},
            success: function (data, textStatus, xhr) {
                shifts = getFormattedData(data.shifts);
                shiftDates = Object.keys(shifts);

                setDefaultView();
                setAvailableDates();
            },
            error: function () {
                console.log('Ajax error!');
            }
        });
    }

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

    function setAvailableDates () {
        let datesAll = getDates(new Date(), shiftDates[0]);
        let datesUnavailable = [];

        for (let i = 0; i < datesAll.length; i++) {
            if (shiftDates.indexOf(datesAll[i]) === -1) {
                datesUnavailable.push(datesAll[i]);
            }
        }
        dateInput.datepicker('setDatesDisabled', datesUnavailable);
        dateInput.datepicker('setEndDate', shiftDates[0]);
    }

    //  === all days between two dates
    function getDates(d1, d2){
        let oneDay = 24 * 3600 * 1000;
        let dStart = d1;
        let dEnd = new Date(d2 + ' 12:00:00 GMT-0700');
        let d = [];

        for (let ms = dStart * 1, last = dEnd * 1; ms <= last; ms += oneDay){
            d.push( formatDate(new Date(ms)) );
        }
        return d;
    }
});