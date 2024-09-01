// Unmap close tab and re-open tab
api.unmap('x');
api.unmap('X');

// Remap open link
api.map('F', 'C');
api.unmap('C');

// History Back/Forward
api.map('H', 'S');
api.map('L', 'D');

// Move Tab Left/Right w/ one press
api.map('>', '>>');
api.map('<', '<<');

// Unmap all searches
api.unmap('sg');
api.unmap('sb');
api.unmap('sd');
api.unmap('sh');
api.unmap('ss');
api.unmap('sw');
api.unmap('se');
api.unmap('sy');

function goto(site) {
    return () => window.open(site);
}

api.mapkey('ogh', 'open github', goto('https://github.com'));
api.mapkey('ofb', 'open facebook', goto('https://facebook.com'));
api.unmap('oy');
api.mapkey('oyt', 'open youtube', goto('https://youtube.com'));
api.mapkey('otl', 'open youtube', goto('https://translate.google.com'));
api.mapkey('olc', 'open leetcode', goto('https://leetcode.com/problemset/all/'));

// Remap open bookmark
api.unmap('ob')
api.map('ob', 'b');
api.unmap('b')

// Remap search google
api.map('o/', 'og');
api.unmap('og');

// set theme
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {w
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;
