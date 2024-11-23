$(document).ready(function() {
    const sessionHistory = JSON.parse(sessionStorage.getItem('sessionHistory')) || {};
    const allTimeHistory = JSON.parse(getCookie('allTimeHistory')) || {};

    const $sessionTbody = $('#sessionHistory tbody');
    $sessionTbody.empty();
    for (const page in sessionHistory) {
        const $tr = $('<tr>').html(`<td>${page}</td><td>${sessionHistory[page]}</td>`);
        $sessionTbody.append($tr);
    }

    const $allTimeTbody = $('#allTimeHistory tbody');
    $allTimeTbody.empty();
    for (const page in allTimeHistory) {
        const $tr = $('<tr>').html(`<td>${page}</td><td>${allTimeHistory[page]}</td>`);
        $allTimeTbody.append($tr);
    }
});
