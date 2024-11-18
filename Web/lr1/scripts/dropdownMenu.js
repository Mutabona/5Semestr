document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.main-menu .has-dropdown').forEach(item => {
        item.addEventListener('mouseover', () => {
            item.querySelector('.dropdown').style.display = 'block';
        });
        item.addEventListener('mouseout', () => {
            item.querySelector('.dropdown').style.display = 'none';
        });
    });
});
