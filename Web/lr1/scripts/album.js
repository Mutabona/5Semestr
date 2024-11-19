function showImage(src) {
    // Создание нового div для большого фото
    var largePhotoDiv = document.createElement('div');
    largePhotoDiv.className = 'large-photo-container';
    largePhotoDiv.innerHTML = '<img src="' + src + '" alt="Большое фото">';

    // Обработчик события для закрытия большого фото по клику вне его
    largePhotoDiv.addEventListener('click', function(event) {
        if (event.target === largePhotoDiv) {
            document.body.removeChild(largePhotoDiv);
        }
    });

    // Добавление нового div на экран
    document.body.appendChild(largePhotoDiv);
}

function showImages() {
    var images = [];
    var titles = [];

    for (var i = 1; i < 16; i++) {
        images[i] = `images/album/a (${i}).JPEG`;
        titles[i] = `Фото ${i}`;
    }

    var album = document.getElementById('photo-album');
    for (var i = 0; i < 3; i++) {
        var container = document.createElement('div');
        container.className = 'container';
        for (var j = 1; j <= 5; j++) {
            var card = document.createElement('div');
            card.className = 'card';

            var img = document.createElement('img');
            img.className = 'album-image';
            img.src = images[i*5+j];
            img.alt = '';
            img.title = titles[i*5+j];
            img.onclick = (function(src) {
                return function() {
                    showImage(src);
                };
            })(images[i*5+j]);

            var textContainer = document.createElement('div');
            var title = document.createElement('h1');
            title.className = 'album-image-text';
            title.textContent = titles[i*5+j];

            textContainer.appendChild(title);
            card.appendChild(img);
            card.appendChild(textContainer);
            container.appendChild(card);
        }
        album.appendChild(container);
    }
}

document.addEventListener('DOMContentLoaded', function() {
    showImages();
});
