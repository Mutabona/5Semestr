const menuItems = document.querySelectorAll('.main-menu li');

menuItems.forEach(item => {
    const link = item.querySelector('a');
    const img = link.querySelector('img');

    item.addEventListener('mouseover', () => {
        if (!item.classList.contains('selected')) {
            img.src = "images/menu/menuout.png";
        }
    });

    item.addEventListener('mouseout', () => {
        if (!item.classList.contains('selected')) {
            img.src = "images/menu/menuover.png";
        }
    });
});


