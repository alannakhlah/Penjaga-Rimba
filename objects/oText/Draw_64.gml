
NineSliceBoxStretched(
    sTextBoxBg,
    x1, y1,
    x2, y2,
    background
);

draw_set_font(fText);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

var _print = string_copy(message, 1, floor(textProgress));

if (responses[0] != -1) && (textProgress >= string_length(message))
{
    for (var i = 0; i < array_length_1d(responses); i++)
    {
        _print += "\n";
        if (i == responseSelected) _print += "> ";
        _print += responses[i];
        if (i == responseSelected) _print += " <";
    }
}

var _textX = (x1 + x2) / 2;
var _textY = y1 + 15;
var _textWidth = (x2 - x1) - 60;

// Ukuran tulisan
var _scale = 0.8;

// Bayangan teks
draw_set_color(c_black);

draw_text_ext_transformed(
    _textX + 1,
    _textY + 1,
    _print,
    15,
    _textWidth,
    _scale,
    _scale,
    0
);

// Teks utama
draw_set_color(c_white);

draw_text_ext_transformed(
    _textX,
    _textY,
    _print,
    15,
    _textWidth,
    _scale,
    _scale,
    0
);
