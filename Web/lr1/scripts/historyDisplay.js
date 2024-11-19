document.addEventListener('DOMContentLoaded', () => {
    const sessionHistory = JSON.parse(localStorage.getItem('sessionHistory')) || {};
    const allTimeHistory = JSON.parse(getCookie('allTimeHistory')) || {};

    const sessionTbody = document.querySelector('#sessionHistory tbody');
    sessionTbody.innerHTML = '';
    for (const page in sessionHistory) {
        const tr = document.createElement('tr');
        tr.innerHTML = `<td>${page}</td><td>${sessionHistory[page]}</td>`;
        sessionTbody.appendChild(tr);
    }

    const allTimeTbody = document.querySelector('#allTimeHistory tbody');
    allTimeTbody.innerHTML = '';
    for (const page in allTimeHistory) {
        const tr = document.createElement('tr');
        tr.innerHTML = `<td>${page}</td><td>${allTimeHistory[page]}</td>`;
        allTimeTbody.appendChild(tr);
    }
});
