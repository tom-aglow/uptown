$(function () {
    $(".navbar-mobile-toggle").click(function () {
        $(this).toggleClass("is-open");
        $('.navbar-mobile').toggleClass("is-open");
    });
});

