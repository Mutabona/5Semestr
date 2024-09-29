function validateQuestion() {
    var question = document.querySelector("textarea[name='q3']");
    var words = question.value.split(" ");
    if (words.length < 20) {
        question.focus();
        alert("Ну введи 20 слов, не западло же.");
        return false;
    }
    return true;
}