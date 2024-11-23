$(document).ready(function() {
    // Создание модального окна
    var modalHTML = `
    <div id="modal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <p>Вы действительно хотите очистить форму?</p>
            <span class="confirm">Да</span>
            <span class="cancel">Нет</span>
        </div>
    </div>
    `;
    $('body').append(modalHTML);

    $('#resetBtn').click(function(event) {
        event.preventDefault();
        $('#modal').show();
    });

    $('.close, .cancel').click(function() {
        $('#modal').hide();
    });

    $('.confirm').click(function() {
        $('form')[0].reset();
        $('#modal').hide();
    });

    $(window).click(function(event) {
        if ($(event.target).is('#modal')) {
            $('#modal').hide();
        }
    });
});
