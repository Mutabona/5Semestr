function showImage(src) {
    var largePhotoDiv = $('<div>', {
        class: 'large-photo-container',
        html: '<img src="' + src + '" alt="Большое фото">',
    });

    largePhotoDiv.on('click', function(event) {
        if (event.target === this) {
            $(this).remove();
        }
    });

    $('body').append(largePhotoDiv);
}

function showImages() {
    var images = [];
    var titles = [];

    for (var i = 1; i < 16; i++) {
        images[i] = `images/album/a (${i}).JPEG`;
        titles[i] = `Фото ${i}`;
    }

    var album = $('#photo-album');
    for (var i = 0; i < 3; i++) {
        var container = $('<div>', { class: 'container' });

        for (var j = 1; j <= 5; j++) {
            var card = $('<div>', { class: 'card' });

            var img = $('<img>', {
                class: 'album-image',
                src: images[i * 5 + j],
                alt: '',
                title: titles[i * 5 + j],
                click: (function(src) {
                    return function() {
                        showImage(src);
                    };
                })(images[i * 5 + j]),
            });

            var textContainer = $('<div>');
            var title = $('<h1>', {
                class: 'album-image-text',
                text: titles[i * 5 + j],
            });

            textContainer.append(title);
            card.append(img).append(textContainer);
            container.append(card);
        }

        album.append(container);
    }
}

$(document).ready(function() {
    showImages();
});
