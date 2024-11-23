$(document).ready(function() {
    const $menuItems = $('.main-menu li');

    $menuItems.each(function() {
        const $item = $(this);
        const $link = $item.find('a');
        const $img = $link.find('img');

        $item.on('mouseover', function() {
            if (!$item.hasClass('selected')) {
                $img.attr('src', 'images/menu/menuout.png');
            }
        });

        $item.on('mouseout', function() {
            if (!$item.hasClass('selected')) {
                $img.attr('src', 'images/menu/menuover.png');
            }
        });
    });
});
