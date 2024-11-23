function validateQuestion() {
    var $question = $("textarea[name='q3']");
    var words = $question.val().split(" ");
    if (words.length < 20) {
        $question.focus();
        alert("Ну введи 20 слов, не западло же.");
        return false;
    }
    return true;
}