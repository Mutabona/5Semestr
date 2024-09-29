function showNav(listType) {
    document.write(`<${listType}>`);
    for (var i = 1; i < arguments.length; i+=2) {
        document.write(`<li>
            <a href="#${arguments[i]}">${arguments[i+1]}</a>
        </li>`);
    }
    document.write(`\<${listType}>`);
}