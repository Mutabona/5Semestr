$(document).ready(function() {
    $('.main-menu .has-dropdown').hover(
        function() {
            $(this).find('.dropdown').css('display', 'block');
        },
        function() {
            $(this).find('.dropdown').css('display', 'none');
        }
    );
});
