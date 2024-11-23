function addBirthdateField() {
    const $birthdateDiv = $('#birthdate');

    const $headerContainer = $('<div>', { class: 'header-container' });

    const $monthSelect = $('<select>', {
        name: 'month',
        required: true,
        html: `
            <option value="01">Январь</option>
            <option value="02">Февраль</option>
            <option value="03">Март</option>
            <option value="04">Апрель</option>
            <option value="05">Май</option>
            <option value="06">Июнь</option>
            <option value="07">Июль</option>
            <option value="08">Август</option>
            <option value="09">Сентябрь</option>
            <option value="10">Октябрь</option>
            <option value="11">Ноябрь</option>
            <option value="12">Декабрь</option>
        `
    });
    $headerContainer.append($monthSelect);

    const $yearSelect = $('<select>', {
        name: 'year',
        required: true,
        html: '<option value="" selected>Год</option>'
    });
    const currentYear = new Date().getFullYear();
    for (let i = currentYear; i >= currentYear - 100; i--) {
        $yearSelect.append(`<option value="${i}">${i}</option>`);
    }
    $headerContainer.append($yearSelect);

    $birthdateDiv.append($headerContainer);

    const $weekdayContainer = $('<div>', { class: 'weekday-container' });
    const weekdays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    weekdays.forEach(weekday => {
        const $dayElement = $('<div>', {
            class: 'weekday',
            text: weekday
        });
        $weekdayContainer.append($dayElement);
    });
    $birthdateDiv.append($weekdayContainer);

    const $dayContainer = $('<div>', {
        class: 'day-container',
        id: 'day-container'
    });
    $birthdateDiv.append($dayContainer);

    const $buttonContainer = $('<div>', { class: 'button-container' });

    const $closeButton = $('<button>', {
        text: 'Закрыть',
        click: toggleCalendar
    });
    $buttonContainer.append($closeButton);

    $birthdateDiv.append($buttonContainer);

    setCurrentDate();

    $monthSelect.on('change', updateDays);
    $yearSelect.on('change', updateDays);
}

function setCurrentDate() {
    const now = new Date();
    const currentMonth = String(now.getMonth() + 1).padStart(2, '0');
    const currentYear = String(now.getFullYear());
    const currentDay = String(now.getDate()).padStart(2, '0');

    $('select[name="month"]').val(currentMonth);
    $('select[name="year"]').val(currentYear);
    updateDays();

    const $dayElement = $('.day').filter(function() {
        return $(this).text() === currentDay;
    });
    if ($dayElement.length) {
        $dayElement.addClass('selected');
    }
}

function toggleCalendar() {
    const $calendar = $('#birthdate');
    const $birthdateInput = $('#birthdate-input');
    if ($calendar.is(':visible')) {
        $calendar.hide();
    } else {
        $calendar.css({
            display: 'block',
            top: $birthdateInput.offset().top + $birthdateInput.outerHeight(),
            left: $birthdateInput.offset().left
        });
    }
}

function confirmDate() {
    const month = $('select[name="month"]').val();
    const day = $('.day.selected').text();
    const year = $('select[name="year"]').val();

    if (month && day && year) {
        $('#birthdate-input').val(`${month}/${day}/${year}`);
        toggleCalendar();
    } else {
        alert("Пожалуйста, выберите полную дату.");
    }
}

function selectDay($dayElement) {
    $('.day.selected').removeClass('selected');
    $dayElement.addClass('selected');
    confirmDate();
}

function updateDays() {
    const month = $('select[name="month"]').val();
    const year = $('select[name="year"]').val();
    const $dayContainer = $('#day-container');

    if (!month || !year) {
        $dayContainer.empty();
        return;
    }

    const daysInMonth = new Date(year, month, 0).getDate();
    const firstDayOfMonth = new Date(year, month - 1, 1).getDay();
    const adjustedFirstDay = (firstDayOfMonth + 6) % 7;

    $dayContainer.empty();

    for (let i = 0; i < adjustedFirstDay; i++) {
        $dayContainer.append($('<div>', { class: 'day empty' }));
    }

    for (let i = 1; i <= daysInMonth; i++) {
        const $dayDiv = $('<div>', {
            class: 'day',
            text: String(i).padStart(2, '0'),
            click: function() {
                selectDay($(this));
            }
        });
        $dayContainer.append($dayDiv);
    }

    const totalSlots = adjustedFirstDay + daysInMonth;
    const remainingSlots = totalSlots % 7;
    if (remainingSlots > 0) {
        for (let i = remainingSlots; i < 7; i++) {
            $dayContainer.append($('<div>', { class: 'day empty' }));
        }
    }
}

$('#birthdate-input').on('click', toggleCalendar);

$(document).ready(function() {
    addBirthdateField();
});
