function updateDateTime() {
    const now = new Date();
    const days = ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота'];
    const formattedDateTime =
        ('0' + now.getHours()).slice(-2) + ':' +
        ('0' + now.getMinutes()).slice(-2) + ':' +
        ('0' + now.getSeconds()).slice(-2) + ' ' +
        ('0' + now.getDate()).slice(-2) + '.' +
        ('0' + (now.getMonth() + 1)).slice(-2) + '.' +
        now.getFullYear() + ' ' +
        days[now.getDay()];
    $('#datetime').text(formattedDateTime);
}

setInterval(updateDateTime, 1000);
updateDateTime();
