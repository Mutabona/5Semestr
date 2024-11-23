function showNav(listType) {
    const $list = $(`<${listType}></${listType}>`);
    for (let i = 1; i < arguments.length; i += 2) {
        const $li = $('<li>').html(`<a href="#${arguments[i]}">${arguments[i+1]}</a>`);
        $list.append($li);
    }
    $('.menu').append($list);
}
