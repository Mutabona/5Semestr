isFioCorrect = false;
isBirthdateCorrect = false;
isAgeCorrect = false;
isEmailCorrect = false;
isPhoneCorrect = false;

window.onload = function () {
    const form = document.querySelector('form');
    const fioInput = document.querySelector("input[name='fio']");
    const birthdateInput = document.querySelector("#birthdate-input");
    const ageSelect = document.querySelector("select[name='age']");
    const emailInput = document.querySelector("input[name='email']");
    const phoneInput = document.querySelector("input[name='phone']");
    const submitButton = document.querySelector("button[type='submit']");
    const confirmDay = document.querySelector("div[class='day']");

    const validateFio = () => {
        const fioRegex = new RegExp("[A-Za-zА-Яа-я]{2,} [A-Za-zА-Яа-я]{2,} [A-Za-zА-Яа-я]{2,}");
        if (!fioRegex.test(fioInput.value.trim())) {
            showError(fioInput, "Не так тебя зовут");
            isFioCorrect = false;
            return false;
        }
        showValid(fioInput);
        isFioCorrect = true;
        return true;
    };

    const validateNumber = () => {
        const phoneRegex = new RegExp("[\\+][37][0-9]{8,10}");
        if (!phoneRegex.test(phoneInput.value.trim())) {
            showError(phoneInput, "Неправильно набран номер");
            isPhoneCorrect = false;
            return false;
        }
        showValid(phoneInput);
        isPhoneCorrect = true;
        return true;
    };

    const validateEmail = () => {
        const emailRegex = new RegExp("[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}");
        if (!emailRegex.test(emailInput.value.trim())) {
            showError(emailInput, "Введите корректный email");
            isEmailCorrect = false;
            return false;
        }
        showValid(emailInput);
        isEmailCorrect = true;
        return true;
    };

    const validateBirthdate = () => {
        if (birthdateInput.value.trim() === '') {
            showError(birthdateInput, "Выберите дату рождения");
            isBirthdateCorrect = false;
            return false;
        }
        showValid(birthdateInput);
        isBirthdateCorrect = true;
        return true;
    };

    const validateAge = () => {
        if (ageSelect.value === '' || ageSelect.value === 'Не выбран') {
            showError(ageSelect, "Выберите возраст");
            isAgeCorrect = false;
            return false;
        }
        showValid(ageSelect);
        isAgeCorrect = true;
        return true;
    };

    const validateForm = () => {
        submitButton.disabled = !(isFioCorrect && isBirthdateCorrect && isAgeCorrect && isEmailCorrect && isPhoneCorrect);
    };

    const showError = (input, message) => {
        input.classList.add('invalid');
        input.classList.remove('valid');
        let errorSpan = input.nextElementSibling;
        errorSpan.textContent = message;
        errorSpan.style.display = 'block';
    };

    const hideError = (input) => {
        input.classList.remove('invalid');
        input.classList.remove('valid');
        const errorSpan = input.nextElementSibling;
        if (errorSpan && errorSpan.classList.contains('error-message')) {
            errorSpan.style.display = 'none';
        }
    };

    const showValid = (input) => {
        input.classList.remove('invalid');
        input.classList.add('valid');
        const errorSpan = input.nextElementSibling;
        if (errorSpan && errorSpan.classList.contains('error-message')) {
            errorSpan.style.display = 'none';
        }
    };

    fioInput.addEventListener('input', () => { validateFio(); validateForm(); });
    fioInput.addEventListener('blur', () => { validateFio(); validateForm(); });
    birthdateInput.addEventListener('change', () => { validateBirthdate(); validateForm(); });
    birthdateInput.addEventListener('input', () => { validateBirthdate(); validateForm(); });
    birthdateInput.addEventListener('blur', () => { validateBirthdate(); validateForm(); });
    confirmDay.addEventListener('click', () => { validateBirthdate(); validateForm();});
    ageSelect.addEventListener('change', () => { validateAge(); validateForm(); });
    ageSelect.addEventListener('blur', () => { validateAge(); validateForm(); });
    emailInput.addEventListener('input', () => { validateEmail(); validateForm(); });
    emailInput.addEventListener('blur', () => { validateEmail(); validateForm(); });
    phoneInput.addEventListener('input', () => { validateNumber(); validateForm(); });
    phoneInput.addEventListener('blur', () => { validateNumber(); validateForm(); });

    form.addEventListener('input', validateForm);
};
