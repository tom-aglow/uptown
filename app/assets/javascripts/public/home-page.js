$(function () {
    // Testimonial carousel
    $('.about__testimonials .carousel').carousel();


    //  Scroll spy
    highlightActiveMenu($(window).scrollTop());

    $(window).scroll(function () {
        highlightActiveMenu($(this).scrollTop());
    });

    //  Smooth scrolling
    $('.nav-link').click(function () {
        smoothScrollToTarget($(this));
        closeMobileNavbar();
    });


    function highlightActiveMenu (curPosition) {
        let pos = curPosition;
        let active = 0;
        let sections = $('section');
        let links = $('.navbar .nav-link');
        let linksMobile = $('.navbar-mobile .nav-link');

        //  check which section is currently scrolling
        sections.each(function (index) {
            if (index > 0) {
                //  start toggling the class when target section is below the window top less than 400px
                if (pos + 400 > $(this).offset().top) {
                    active = index;
                }
            }
        });

        //  remove active class for all links
        links.removeClass('active');
        linksMobile.removeClass('active');

        //  add it only for active section
        links.eq(active).addClass('active');
        linksMobile.eq(active).addClass('active');
    }

    function smoothScrollToTarget(target) {
        let targetID = '#' + target.attr('href').split('#')[1];
        let startY = $(window).scrollTop();
        let adj = ($(window).width() > 500) ? 80 : 70;
        let stopY = $(targetID).offset().top - adj;
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

    function closeMobileNavbar () {
        setTimeout(function () {
            $('.navbar-mobile, .navbar-mobile-toggle').removeClass('is-open');
        }, 200);
    }
});

