$(function () {
    //  ==================
    //  *** VARIABLES ***
    //  ==================

    //  Variables with DOM elements
    let step1 = $('.reserv__step-1');
    let step2 = $('.reserv__step-2');
    let step3 = $('.reserv__step-3');

    let barbersImages = $('.barbers__img__cont');
    let barbersNames = $('.barbers__names span');
    let skipStep = $('#skip-step');

    //      form elements
    let _shiftDate = $('#shift_date');
    let _shiftTime = $('#shift_time');
    let _shiftBarberID = $('#shift_barber_id');
    let _reqServiceID = $('#requisition_service_id');

    //      UI elements for selecting date, time and service
    let shiftDateUI = $('#datepicker');
    let timesUI = $('#times');
    let shiftServiceUI = $('#select-service');

    //  Global variables
    let shifts = {};
    let shiftDates = [];

    //  ======================================
    //  *** PAGE & ELEMENTS INITIALIZATION ***
    //  ======================================

    //  Date picker initialization
    shiftDateUI.datepicker({
        format: 'yyyy-mm-dd',
        orientation: 'left bottom',
        startDate: new Date(),                  //  picker is initiated with no available dates first
        endDate: new Date(Date.now() - 864e5),
        todayHighlight: true,
        autoclose: true
    });

    //  Phone mask input
    $('#client_phone').mask('999.999.9999');

    //  On page load check if fields have some values after validation
    //      if so, preselect UI elements for user
    //          barber and shift info

    if (_shiftBarberID.val() !== '') {
        let index = _shiftBarberID.val() - 1;

        //  highlight barber image and name
        selectBarber(index);

        //  make ajax request to retrieve info about barbers availability
        getShiftsInfo(index + 1);

        if (_shiftDate.val() !== '') {
            //  setup date picker value
            shiftDateUI.val(_shiftDate.val());
            //  see other actions in ajax request since it is asynchronous and we have to wait when it finishes
        }
    }

    //          service info
    if (_reqServiceID.val() !== '') {
        shiftServiceUI.val(_reqServiceID.val());
    }

    //  Reservation tiles animation
    step1.addClass('animate-1');

    //  ===================
    //  *** PAGE EVENTS ***
    //  ===================

    //  CLICK EVENT ON BARBER IMAGE & BARBER NAME
    barbersImages.click(function () {
        let index = barbersImages.index($(this));

        //  delete all time boxes and set date to default
        setDefaultView();

        //  highlight barber image and name
        selectBarber(index);

        //  make ajax request to retrieve info about barbers availability
        getShiftsInfo(index + 1);

        //  animate current and next section
        animateSection2();
    });

    barbersNames.click(function () {
        let index = barbersNames.index($(this));

        //  delete all time boxes and set date to default
        setDefaultView();

        //  highlight barber image and name
        selectBarber(index);

        //  make ajax request to retrieve info about barbers availability
        getShiftsInfo(index + 1);

        //  animate current and next section
        animateSection2();
    });

    //  EVENTS WHEN SERVICES SELECT BOX CHANGES ITS VALUE > UPDATE VALUES IN CORRESPONDENT FORM INPUT
    shiftServiceUI.change(function () {
        _reqServiceID.val($(this).val());

        //  animate 3rd section if necessary
        if ($('.time.active').length > 0) {
            animateSection3();
        }
    });


    //  DATE PICKER ON CHANGE EVENT
    shiftDateUI.datepicker().on('changeDate', function () {
        //  change the value of input box
        let selectedDate = formatDate(shiftDateUI.datepicker('getDate'));
        _shiftDate.val(selectedDate);

        //  render time boxes
        let availableTimes = shifts[selectedDate];

        renderTimeBoxes(availableTimes);
    });

    //  CLICK EVENT ON TIME ELEMENT
    $(document).on('click', '.time', function () {
        let $this = $(this);
        //  change value of corresponding input field
        _shiftTime.val($this.data('time'));
        //      and select barber in case if that step was skipped
        selectBarber($this.data('barber-id') - 1);
        // _shiftBarberID.val($this.data('barber-id'));

        //  remove active class from all elements
        timesUI.children().removeClass('active');

        //  add active class only for target element
        $this.addClass('active');

        //  animate next section
        if (shiftServiceUI.val() !== null) {
            animateSection3();
        }
    });

    //  CLICK EVENT ON SKIP STEP LINK
    skipStep.click(function () {
        //  delete all time boxes and set date to default
        setDefaultView();

        //  make ajax request to retrieve info about barbers availability
        getShiftsInfo();

        //  animate current and next section
        animateSection2();
    });


    //  =================
    //  *** FUNCTIONS ***
    //  =================

    //  === highlight selected barber
    function selectBarber (index) {
        //  add barber_id to the form
        _shiftBarberID.val(index + 1);

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
        timesUI.empty();
        _shiftDate.val('');
        _shiftTime.val('');
    }

    //  === function for section tiles animation
    function animateSection2 () {
        step1.addClass('animate-2');
        setTimeout(function () {
            step1.addClass('static');
            step2.addClass('visible');
            step3.addClass('visible');
            setTimeout(function () {
                if ($(window).width() < 850) {
                  smoothScrollToTarget(step2);
                };
                step2.addClass('animate');
            }, 100)
        }, 500)
    }

    function animateSection3 () {
        if ($(window).width() < 1225) {
            smoothScrollToTarget(step3);
        }
        step3.addClass('animate');
    }

    //  === Retrieve, format & manage data from AJAX-request

    function getShiftsInfo (barber_id = '') {
        $.ajax({
            url: "/booking_info",
            type: "GET",
            format: "json",
            data: { barber_id: barber_id },
            complete: function () {},
            success: function (data, textStatus, xhr) {
                shifts = getFormattedData(data.shifts);
                console.log(shifts);
                shiftDates = Object.keys(shifts);

                setAvailableDates();

                //  auto select first available date & render time boxes for it
                let startDate = new Date(shiftDates[shiftDates.length - 1] + ' 12:00:00 GMT-0700 (PDT)');
                shiftDateUI.datepicker('update', startDate);
                _shiftDate.val(shiftDates[shiftDates.length - 1]);


                //  create time boxes if date was already selected
                if (_shiftDate.val() !== '') {
                    let availableTimes = shifts[_shiftDate.val()];
                    renderTimeBoxes(availableTimes);

                    //  and select time if it was selected in previous request
                    if (_shiftTime.val() !== '') {
                        console.log('hi');
                        $('*[data-time="' + _shiftTime.val() + '"]').addClass('active');
                    }
                }
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
            let obj = {};
            obj.time = shifts[i].time;
            obj.barber_id = shifts[i].barber_id;
            dates[key].push(obj);
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
        shiftDateUI.datepicker('setDatesDisabled', datesUnavailable);
        shiftDateUI.datepicker('setEndDate', shiftDates[0]);
    }

    function renderTimeBoxes(times) {
        timesUI.empty();

        for (let i = 0; i < times.length; i++) {
            let box = $("<span class='time' data-time=" + times[i].time + " data-barber-id=" + times[i].barber_id + "></span>").text(formatAMPM(times[i].time));
            timesUI.append(box);
        }
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

  //  === smooth scrolling function

  function smoothScrollToTarget(target) {
    let startY = $(window).scrollTop();
    let adj = ($(window).width() > 500) ? 180 : 90;
    let stopY = target.offset().top - adj;
    let distance = stopY > startY ? stopY - startY : startY - stopY;

    if (distance < 100) {
      scrollTo(0, stopY);
      return;
    }

    let speed = Math.round(distance / 100);

    if (speed >= 20) speed = 20;
    let step = Math.round(distance / 25);
    let leapY = stopY > startY ? startY + step : startY - step;
    let timer = 0;


    if (stopY > startY) {
      for ( let i=startY; i<stopY; i+=step ) {
        setTimeout("window.scrollTo(0, "+leapY+")", timer * speed);
        leapY += step; if (leapY > stopY) leapY = stopY; timer++;
      }
      return;
    }
    for ( let i=startY; i>stopY; i-=step ) {
      setTimeout("window.scrollTo(0, "+leapY+")", timer * speed);
      leapY -= step; if (leapY < stopY) leapY = stopY; timer++;
    }

    return false;
  }
});