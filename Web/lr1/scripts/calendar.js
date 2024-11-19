// calendar.js

// Function to add birth date fields to calendar div
function addBirthdateField() {
    const birthdateDiv = document.getElementById('birthdate');

    // Create a container for month and year select elements
    const headerContainer = document.createElement('div');
    headerContainer.className = 'header-container';

    // Create month select element
    const monthSelect = document.createElement('select');
    monthSelect.name = 'month';
    monthSelect.required = true;
    monthSelect.innerHTML = `
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
    `;
    headerContainer.appendChild(monthSelect);

    // Create year select element
    const yearSelect = document.createElement('select');
    yearSelect.name = 'year';
    yearSelect.required = true;
    yearSelect.innerHTML = '<option value="" selected>Год</option>';
    const currentYear = new Date().getFullYear();
    for (let i = currentYear; i >= currentYear - 100; i--) {
        yearSelect.innerHTML += `<option value="${i}">${i}</option>`;
    }
    headerContainer.appendChild(yearSelect);

    birthdateDiv.appendChild(headerContainer);

    // Create weekday names
    const weekdayContainer = document.createElement('div');
    weekdayContainer.className = 'weekday-container';
    const weekdays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    weekdays.forEach(weekday => {
        const dayElement = document.createElement('div');
        dayElement.className = 'weekday';
        dayElement.innerText = weekday;
        weekdayContainer.appendChild(dayElement);
    });
    birthdateDiv.appendChild(weekdayContainer);

    // Create days using div elements
    const dayContainer = document.createElement('div');
    dayContainer.className = 'day-container';
    dayContainer.id = 'day-container';
    birthdateDiv.appendChild(dayContainer);

    // Create a container for buttons
    const buttonContainer = document.createElement('div');
    buttonContainer.className = 'button-container';

    // Create a button to close the calendar
    const closeButton = document.createElement('button');
    closeButton.innerText = 'Закрыть';
    closeButton.onclick = toggleCalendar;
    buttonContainer.appendChild(closeButton);

    // Create a button to confirm the date
    const confirmButton = document.createElement('button');
    confirmButton.innerText = 'Выбрать';
    confirmButton.onclick = confirmDate;
    buttonContainer.appendChild(confirmButton);

    birthdateDiv.appendChild(buttonContainer);

    // Set current date
    setCurrentDate();

    // Add event listeners to month and year select elements
    monthSelect.addEventListener('change', updateDays);
    yearSelect.addEventListener('change', updateDays);
}

// Function to set the current date in the calendar
function setCurrentDate() {
    const now = new Date();
    const currentMonth = String(now.getMonth() + 1).padStart(2, '0');
    const currentYear = String(now.getFullYear());
    const currentDay = String(now.getDate()).padStart(2, '0');

    document.querySelector('select[name="month"]').value = currentMonth;
    document.querySelector('select[name="year"]').value = currentYear;
    updateDays();

    const dayElement = Array.from(document.querySelectorAll('.day')).find(day => day.innerText === currentDay);
    if (dayElement) {
        dayElement.classList.add('selected');
    }
}

// Function to show or hide the calendar
function toggleCalendar() {
    const calendar = document.getElementById('birthdate');
    if (calendar.style.display === 'block') {
        calendar.style.display = 'none';
    } else {
        calendar.style.display = 'block';
        const birthdateInput = document.getElementById('birthdate-input');
        calendar.style.top = `${birthdateInput.offsetTop + birthdateInput.offsetHeight}px`;
        calendar.style.left = `${birthdateInput.offsetLeft}px`;
    }
}

// Function to confirm and display the selected date
function confirmDate() {
    const month = document.querySelector('select[name="month"]').value;
    const day = document.querySelector('.day.selected')?.innerText;
    const year = document.querySelector('select[name="year"]').value;

    if (month && day && year) {
        document.getElementById('birthdate-input').value = `${month}/${day}/${year}`;
        toggleCalendar();
    } else {
        alert("Пожалуйста, выберите полную дату.");
    }
}

// Function to select a day
function selectDay(dayElement) {
    const previouslySelected = document.querySelector('.day.selected');
    if (previouslySelected) {
        previouslySelected.classList.remove('selected');
    }
    dayElement.classList.add('selected');
}

// Function to update days based on selected month and year
function updateDays() {
    const month = document.querySelector('select[name="month"]').value;
    const year = document.querySelector('select[name="year"]').value;
    const dayContainer = document.getElementById('day-container');

    if (!month || !year) {
        dayContainer.innerHTML = '';
        return;
    }

    const daysInMonth = new Date(year, month, 0).getDate();
    const firstDayOfMonth = new Date(year, month - 1, 1).getDay();
    const adjustedFirstDay = (firstDayOfMonth + 6) % 7; // Adjust for the week starting on Monday

    dayContainer.innerHTML = '';

    // Add empty divs for the previous month's days
    for (let i = 0; i < adjustedFirstDay; i++) {
        const emptyDiv = document.createElement('div');
        emptyDiv.className = 'day empty';
        dayContainer.appendChild(emptyDiv);
    }

    for (let i = 1; i <= daysInMonth; i++) {
        const dayDiv = document.createElement('div');
        dayDiv.className = 'day';
        dayDiv.innerText = String(i).padStart(2, '0');
        dayDiv.onclick = () => selectDay(dayDiv);
        dayContainer.appendChild(dayDiv);
    }

    // Add empty divs to ensure the last row is properly aligned
    const totalSlots = adjustedFirstDay + daysInMonth;
    const remainingSlots = totalSlots % 7;
    if (remainingSlots > 0) {
        for (let i = remainingSlots; i < 7; i++) {
            const emptyDiv = document.createElement('div');
            emptyDiv.className = 'day empty';
            dayContainer.appendChild(emptyDiv);
        }
    }
}

// Add event listener to input field
document.getElementById('birthdate-input').addEventListener('click', toggleCalendar);

// Call function to add birth date fields on page load
window.onload = addBirthdateField;
