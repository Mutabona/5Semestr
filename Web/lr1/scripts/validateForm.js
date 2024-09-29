function validateFio() {
    var fioInput = document.querySelector("input[name='fio']");

    var fioRegex = new RegExp("[A-Za-zА-Яа-я]{2,} [A-Za-zА-Яа-я]{2,} [A-Za-zА-Яа-я]{2,}");
    if (!fioRegex.test(fioInput.value)) {
        alert("Не так тебя зовут");
        fioInput.focus();
        return false;
    }
    return true;
}

function validateNumber() {
    var phoneInput = document.querySelector("input[name='phone']");

    var phoneRegex = new RegExp("[\+][37][0-9]{8,10}");
    if (!phoneRegex.test(phoneInput.value)) {
        alert("Неправильно набран номер");
        phoneInput.focus();
        return false;
    }
    return true;
}

function validateForm() {
    if (!validateFio()) return false;
    return validateNumber();
}