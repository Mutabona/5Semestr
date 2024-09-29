function showImages() {
    var images = [];
    var titles = [];

    for (var i = 1; i < 16; i++) {
        images[i] = `images/album/a (${i}).JPEG`;
        titles[i] = `Фото ${i}`;
    }
    for (var i = 0; i < 3; i++) {
        document.write(
            "<div class=\"container\">"
        );
        for (var j = 1; j <= 5; j++) {
            document.write(
                "<div class=\"card\">\n" +
                `    <img class=\"album-image\" src=\"${images[i*5+j]}\" alt=\"\" title=\"${titles[i*5+j]} \">\n` +
                "    <div>\n" +
                `       <h1 class=\"album-image-text\">${titles[i*5+j]}</h1>\n` +
                "    </div>\n" +
                "</div>"
            );
        }
        document.write("</div>");
    }
}