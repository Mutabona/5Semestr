$(document).ready(function() {
    const M = 1;

    $('.hover-element').hover(
        function() {
            const message = $(this).data('popover');
            const $popover = $('<div class="popover"></div>').text(message);
            $('body').append($popover);
            const offset = $(this).offset();
            $popover.css({
                top: offset.top + $(this).outerHeight(),
                left: offset.left + ($(this).outerWidth() - $popover.outerWidth()) / 2
            }).fadeIn(200);
        },
        function() {
            const $popover = $('.popover');
            setTimeout(function() {
                $popover.fadeOut(200, function() {
                    $popover.remove();
                });
            }, M * 1000);
        }
    );
});
