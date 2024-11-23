function updateSessionHistory(page) {
    const sessionHistory = JSON.parse(sessionStorage.getItem('sessionHistory')) || {};
    sessionHistory[page] = (sessionHistory[page] || 0) + 1;
    sessionStorage.setItem('sessionHistory', JSON.stringify(sessionHistory));
}

function updateAllTimeHistory(page) {
    const allTimeHistory = JSON.parse(getCookie('allTimeHistory')) || {};
    allTimeHistory[page] = (allTimeHistory[page] || 0) + 1;
    setCookie('allTimeHistory', JSON.stringify(allTimeHistory), 365);
}

function updateHistory(page) {
    updateSessionHistory(page);
    updateAllTimeHistory(page);
}

document.addEventListener('DOMContentLoaded', () => {
    const page = window.location.pathname;
    updateHistory(page);
});