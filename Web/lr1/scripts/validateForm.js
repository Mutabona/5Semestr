let isFioCorrect = false;
let isBirthdateCorrect = false;
let isAgeCorrect = false;
let isEmailCorrect = false;
let isPhoneCorrect = false;

$(window).on('load', function () {
    const $form = $('form');
    const $fioInput = $("input[name='fio']");
    const $birthdateInput = $("#birthdate-input");
    const $ageSelect = $("select[name='age']");
    const $emailInput = $("input[name='email']");
    const $phoneInput = $("input[name='phone']");
    const $submitButton = $("button[type='submit']");
    const $confirmDay = $("div.day");

    const validateFio = () => {
        const fioRegex = new RegExp("[A-Za-zА-Яа-я]{2,} [A-Za-zА-Яа-я]{2,} [A-Za-zА-Яа-я]{2,}");
        if (!fioRegex.test($fioInput.val().trim())) {
            showError($fioInput, "Не так тебя зовут");
            isFioCorrect = false;
            return false;
        }
        showValid($fioInput);
        isFioCorrect = true;
        return true;
    };

    const validateNumber = () => {
        const phoneRegex = new RegExp("[\\+][37][0-9]{8,10}");
        if (!phoneRegex.test($phoneInput.val().trim())) {
            showError($phoneInput, "Неправильно набран номер");
            isPhoneCorrect = false;
            return false;
        }
        showValid($phoneInput);
        isPhoneCorrect = true;
        return true;
    };

    const validateEmail = () => {
        const emailRegex = new RegExp("[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}");
        if (!emailRegex.test($emailInput.val().trim())) {
            showError($emailInput, "Введите корректный email");
            isEmailCorrect = false;
            return false;
        }
        showValid($emailInput);
        isEmailCorrect = true;
        return true;
    };

    const validateBirthdate = () => {
        if ($birthdateInput.val().trim() === '') {
            showError($birthdateInput, "Выберите дату рождения");
            isBirthdateCorrect = false;
            return false;
        }
        showValid($birthdateInput);
        isBirthdateCorrect = true;
        return true;
    };

    const validateAge = () => {
        if ($ageSelect.val() === '' || $ageSelect.val() === 'Не выбран') {
            showError($ageSelect, "Выберите возраст");
            isAgeCorrect = false;
            return false;
        }
        showValid($ageSelect);
        isAgeCorrect = true;
        return true;
    };

    const validateForm = () => {
        $submitButton.prop('disabled', !(isFioCorrect && isBirthdateCorrect && isAgeCorrect && isEmailCorrect && isPhoneCorrect));
    };

    const showError = ($input, message) => {
        $input.addClass('invalid').removeClass('valid');
        let $errorSpan = $input.next('.error-message');
        if ($errorSpan.length) {
            $errorSpan.text(message).show();
        }
    };

    const hideError = ($input) => {
        $input.removeClass('invalid').removeClass('valid');
        const $errorSpan = $input.next('.error-message');
        if ($errorSpan.length) {
            $errorSpan.hide();
        }
    };

    const showValid = ($input) => {
        $input.addClass('valid').removeClass('invalid');
        const $errorSpan = $input.next('.error-message');
        if ($errorSpan.length) {
            $errorSpan.hide();
        }
    };

    $fioInput.on('input blur', function() { validateFio(); validateForm(); });
    $birthdateInput.on('change input blur', function() { validateBirthdate(); validateForm(); });
    $confirmDay.on('click', function() { validateBirthdate(); validateForm(); });
    $ageSelect.on('change blur', function() { validateAge(); validateForm(); });
    $emailInput.on('input blur', function() { validateEmail(); validateForm(); });
    $phoneInput.on('input blur', function() { validateNumber(); validateForm(); });

    $form.on('input', validateForm);
});
