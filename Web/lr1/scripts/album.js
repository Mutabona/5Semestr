let currentIndex = 0;
const images = [];
const titles = [];

for (let i = 1; i <= 15; i++) {
    images.push(`images/album/a (${i}).JPEG`);
    titles.push(`Фото ${i}`);
}

function showImage(index) {
    const largePhotoDiv = $('<div>', {
        class: 'large-photo-container',
        html: `
            <img src="${images[index]}" alt="Большое фото">
            <div class="photo-title">${titles[index]}</div>
            <div class="arrow left-arrow">&#9664;</div>
            <div class="arrow right-arrow">&#9654;</div>
        `,
    });

    largePhotoDiv.on('click', function(event) {
        if ($(event.target).hasClass('large-photo-container')) {
            $(this).fadeOut(300, function() {
                $(this).remove();
            });
        }
    });

    largePhotoDiv.find('.left-arrow').on('click', function(event) {
        event.stopPropagation();
        currentIndex = (currentIndex - 1 + images.length) % images.length;
        updateLargePhoto(largePhotoDiv, currentIndex);
    });

    largePhotoDiv.find('.right-arrow').on('click', function(event) {
        event.stopPropagation();
        currentIndex = (currentIndex + 1) % images.length;
        updateLargePhoto(largePhotoDiv, currentIndex);
    });

    $('body').append(largePhotoDiv.hide().fadeIn(300));
}

function updateLargePhoto(container, index) {
    container.find('img').fadeOut(300, function() {
        $(this).attr('src', images[index]).fadeIn(300);
    });
    container.find('.photo-title').fadeOut(300, function() {
        $(this).text(titles[index]).fadeIn(300);
    });
}

function showImages() {
    const album = $('#photo-album');

    for (let i = 0; i < 3; i++) {
        const container = $('<div>', { class: 'container' });

        for (let j = 1; j <= 5; j++) {
            const index = i * 5 + j - 1;
            const card = $('<div>', { class: 'card' });

            const img = $('<img>', {
                class: 'album-image',
                src: images[index],
                alt: '',
                title: titles[index],
                click: function() {
                    currentIndex = index;
                    showImage(index);
                },
            });

            const textContainer = $('<div>');
            const title = $('<h1>', {
                class: 'album-image-text',
                text: titles[index],
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
