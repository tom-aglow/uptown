$(function () {
    // Mobile navber toggling
    $(".navbar-mobile-toggle").click(function () {
        $(this).toggleClass("is-open");
        $('.navbar-mobile').toggleClass("is-open");
    });

    // Testimonial carousel
    $('.about__testimonials .carousel').carousel();
});

