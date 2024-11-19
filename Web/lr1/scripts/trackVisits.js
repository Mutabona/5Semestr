function updateSessionHistory(page) {
    const sessionHistory = JSON.parse(localStorage.getItem('sessionHistory')) || {};
    sessionHistory[page] = (sessionHistory[page] || 0) + 1;
    localStorage.setItem('sessionHistory', JSON.stringify(sessionHistory));
    console.log("Session History Updated:", sessionHistory);
}

function updateAllTimeHistory(page) {
    const allTimeHistory = JSON.parse(getCookie('allTimeHistory')) || {};
    allTimeHistory[page] = (allTimeHistory[page] || 0) + 1;
    setCookie('allTimeHistory', JSON.stringify(allTimeHistory), 365);
    console.log("All Time History Updated:", allTimeHistory);
}

function updateHistory(page) {
    updateSessionHistory(page);
    updateAllTimeHistory(page);
}

let pageVisible = true;
let formSubmit = false;
let linkClick = false;

document.addEventListener('visibilitychange', () => {
    if (document.visibilityState === 'hidden') {
        pageVisible = false;
    } else {
        pageVisible = true;
    }
});

document.addEventListener('submit', (event) => {
    formSubmit = true;
});

document.addEventListener('click', (event) => {
    if (event.target.tagName === 'A' && event.target.href) {
        linkClick = true;
    }
});

window.addEventListener('beforeunload', (event) => {
    if (!formSubmit && !linkClick) {
        console.log('Clearing session history from localStorage.'); // Отладочное сообщение
        localStorage.removeItem('sessionHistory');
    }
});

document.addEventListener('DOMContentLoaded', () => {
    const page = window.location.pathname;
    updateHistory(page);
});