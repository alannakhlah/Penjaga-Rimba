/// @desc Draw GUI

// =====================================
// MENU CHARACTER FRAME
// =====================================

var _menuPlayerFrame = floor(menuPlayerImage) mod 8;


// =====================================
// TITLE
// =====================================

if (titleVisible > 0)
{
    draw_sprite(
        sTitle,
        0,
        0,
        -RESOLUTION_H + titleVisible * RESOLUTION_H
    );

    draw_set_alpha(
        titleVisible * abs(sin(get_timer() * 0.000001 * pi))
    );

    draw_sprite(sTitle, 1, 0, 10);

    draw_set_alpha(1.0);
}


// =====================================
// MAIN MENU
// =====================================


if (slotsVisible > 0 && !creditsOpen && !tutorialOpen)
{
    var _menuOptions = [
        "New Game",
        "Continue",
        "Tutorial",
        "Credits",
        "Exit to Desktop"
    ];

    draw_set_alpha(slotsVisible);

    for (var _slot = 0; _slot < 5; _slot++)
    {
        var _y = 5 + _slot * 34;
        var _x = 160;

        var _img = 2;

        if (slotSelected == _slot)
        {
            _img = 3;

            draw_sprite(
                sMenuPlayer,
                _menuPlayerFrame,
                _x - 32,
                _y + 15
            );
        }

        NineSliceBoxStretched(
            sTextBoxBg,
            _x,
            _y,
            312,
            _y + 30,
            _img
        );

        draw_set_font(fText);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_set_color(c_white);

        draw_text(
            _x + 12,
            _y + 15,
            _menuOptions[_slot]
        );
    }

    draw_set_alpha(1.0);
}


 // =====================================
 // TUTORIAL SCREEN
 // =====================================

if (tutorialOpen)
{
    // ---------------------------------
    // DARKEN rTitle BACKGROUND
    // ---------------------------------

    draw_set_color(c_black);
    draw_set_alpha(0.85);

    draw_rectangle(
        0,
        0,
        RESOLUTION_W,
        RESOLUTION_H,
        false
    );

    draw_set_alpha(1.0);


    // ---------------------------------
    // TITLE
    // ---------------------------------

    draw_set_font(fText);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);

    draw_text_transformed(
        RESOLUTION_W * 0.5,
        15,
        "TUTORIAL",
        1,
        1,
        0
    );


    // ---------------------------------
    // TUTORIAL PANEL
    // ---------------------------------

    var _left = 15;
    var _top = 30;
    var _right = 305;
    var _bottom = 158;

    draw_set_color(make_color_rgb(90, 90, 90));
    draw_set_alpha(0.85);

    draw_rectangle(
        _left,
        _top,
        _right,
        _bottom,
        false
    );

    draw_set_alpha(1.0);


    // ---------------------------------
    // CONTROL INFORMATION
    // ---------------------------------

    var _scale = 0.55;

    var _keyColor = make_color_rgb(255, 215, 120);
    var _descColor = c_white;

    draw_set_font(fText);
    draw_set_valign(fa_middle);


    // LEFT COLUMN

    draw_set_halign(fa_left);

    draw_set_color(_keyColor);
    draw_text_transformed(28, 49, "WASD", _scale, _scale, 0);

    draw_set_color(_descColor);
    draw_text_transformed(75, 49, "Move", _scale, _scale, 0);


    draw_set_color(_keyColor);
    draw_text_transformed(28, 70, "L-CLICK", _scale, _scale, 0);

    draw_set_color(_descColor);
    draw_text_transformed(75, 70, "Attack / Throw", _scale, _scale, 0);


    draw_set_color(_keyColor);
    draw_text_transformed(28, 91, "R-CLICK", _scale, _scale, 0);

    draw_set_color(_descColor);
    draw_text_transformed(75, 91, "Use Equipment", _scale, _scale, 0);


    // RIGHT COLUMN

    draw_set_color(_keyColor);
    draw_text_transformed(170, 49, "Q", _scale, _scale, 0);

    draw_set_color(_descColor);
    draw_text_transformed(195, 49, "Change Equipment", _scale, _scale, 0);


    draw_set_color(_keyColor);
    draw_text_transformed(170, 70, "E", _scale, _scale, 0);

    draw_set_color(_descColor);
    draw_text_transformed(195, 70, "Interact / Confirm", _scale, _scale, 0);


    draw_set_color(_keyColor);
    draw_text_transformed(170, 91, "SPACE", _scale, _scale, 0);

    draw_set_color(_descColor);
    draw_text_transformed(210, 91, "Roll", _scale, _scale, 0);


    // ---------------------------------
    // EXTRA INFORMATION
    // ---------------------------------

    draw_set_halign(fa_center);

    draw_set_color(make_color_rgb(255, 215, 120));

    draw_text_transformed(
        RESOLUTION_W * 0.5,
        119,
        "COMBAT TIPS",
        0.65,
        0.65,
        0
    );

    draw_set_color(c_white);

    draw_text_transformed(
        RESOLUTION_W * 0.5,
        133,
        "Carry hat or bomb to throw instead of attack.",
        0.42,
        0.42,
        0
    );


     // ---------------------------------
    // BACK BUTTON
    // ---------------------------------

    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);

    draw_set_color(c_red);

    draw_text_transformed(
        10,
        169,
        "E",
        0.8,
        0.8,
        0
    );

    draw_set_color(c_white);

    draw_text_transformed(
        20,
        169,
        "BACK",
        0.8,
        0.8,
        0
    );


    // ---------------------------------
    // RESET DRAW SETTINGS
    // ---------------------------------

    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}


// =====================================
// CREDITS SCREEN
// =====================================

if (creditsOpen)
{
    // ---------------------------------
    // DARKEN rTitle BACKGROUND
    // ---------------------------------

    draw_set_color(c_black);
    draw_set_alpha(0.85);

    draw_rectangle(
        0,
        0,
        RESOLUTION_W,
        RESOLUTION_H,
        false
    );

    draw_set_alpha(1.0);


    // ---------------------------------
    // CREDITS TITLE
    // ---------------------------------

    draw_set_font(fText);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);

    draw_text_transformed(
        RESOLUTION_W * 0.5,
        14,
        "CREDITS",
        1,
        1,
        0
    );


    // ---------------------------------
    // CREDITS FRAME
    // ---------------------------------

    var _left = 30;
    var _top = 29;
    var _right = 290;
    var _bottom = 160;

    draw_set_color(make_color_rgb(125, 125, 125));
    draw_set_alpha(0.85);

    draw_rectangle(
        _left,
        _top,
        _right,
        _bottom,
        true
    );

    draw_set_alpha(1.0);

// ---------------------------------
// CREDITS CONTENT (AUTO LAYOUT)
// ---------------------------------

var _scale = 0.55;        // ukuran font SEMUA teks credits
var _gapSection = 5;      // jarak antar bagian
var _colLabel = make_color_rgb(175, 175, 175);   // warna label
var _colName  = c_white;                         // warna nama
var _colTitle = make_color_rgb(255, 215, 120);   // warna judul produksi

var _centerX = RESOLUTION_W * 0.5;

draw_set_font(fText);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

var _lh = string_height("A") * _scale;   // tinggi 1 baris

// Data: [label, nama]  (pakai \n untuk nama lebih dari 1 baris)
var _credits = [
    ["GAME DIRECTOR / PROGRAMMER", "NAKHLAH MAULANA ADHIASYA"],
    ["PRODUCER",                   "NAKHLAH MAULANA ADHIASYA"],
    ["SUPPORT PRODUCER",           "SHELIA POPYTHA LATIF\nDAFA PRIMA NUGRAHA"],
    ["ASSETS",                     "SARA SPALDING"],
    ["MUSIC / SOUND",              "HARMARD'S BGM\nBGMEMON"]
];

var _productionText = "A PENJAGA RIMBA PRODUCTION";

// Hitung total tinggi supaya konten rata tengah di frame
var _totalH = _lh + _gapSection;   // judul produksi

for (var i = 0; i < array_length(_credits); i++)
{
    var _nameLines = string_count("\n", _credits[i][1]) + 1;

    _totalH += _lh * (1 + _nameLines);

    if (i < array_length(_credits) - 1)
    {
        _totalH += _gapSection;
    }
}

var _yy = _top + ((_bottom - _top) - _totalH) * 0.5;

// Judul produksi
draw_set_color(_colTitle);
draw_text_transformed(_centerX, _yy, _productionText, _scale, _scale, 0);
_yy += _lh + _gapSection;

// Semua bagian credits
for (var i = 0; i < array_length(_credits); i++)
{
    var _label = _credits[i][0];
    var _name  = _credits[i][1];
    var _nameLines = string_count("\n", _name) + 1;

    // Label
    draw_set_color(_colLabel);
    draw_text_transformed(_centerX, _yy, _label, _scale, _scale, 0);
    _yy += _lh;

    // Nama
    draw_set_color(_colName);
    draw_text_transformed(_centerX, _yy, _name, _scale, _scale, 0);
    _yy += _lh * _nameLines + _gapSection;
}


    // ---------------------------------
    // BACK BUTTON
    // ---------------------------------

    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);

    draw_set_color(c_red);

    draw_text_transformed(
        10,
        169,
        "E",
        0.8,
        0.8,
        0
    );

    draw_set_color(c_white);

    draw_text_transformed(
        20,
        169,
        "BACK",
        0.8,
        0.8,
        0
    );


    // ---------------------------------
    // RESET DRAW SETTINGS
    // ---------------------------------

    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}