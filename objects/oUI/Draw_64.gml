
/// @desc Draw UI

// ==================================
// DRAW HEALTH
// ==================================

var _playerHealth = global.playerHealth;
var _playerHealthMax = global.playerHealthMax;
var _playerHealthFrac = frac(_playerHealth);

_playerHealth -= _playerHealthFrac;

for (var i = 1; i <= _playerHealthMax; i++)
{
    var _imageIndex = (i > _playerHealth);

    if (i == _playerHealth + 1)
    {
        _imageIndex += (_playerHealthFrac > 0);
        _imageIndex += (_playerHealthFrac > 0.25);
        _imageIndex += (_playerHealthFrac > 0.5);
    }

    draw_sprite(
        sHealth,
        _imageIndex,
        8 + ((i - 1) * 16),
        8
    );
}


// ==================================
// COINS
// ==================================

var _xx, _yy;

// Coin Icon
_xx = 30;
_yy = 26.5;

draw_sprite(sCoinUI, 0, _xx, _yy);

// Coin Text
draw_set_colour(c_black);
draw_set_font(fText);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

_xx += sprite_get_width(sCoinUI) + 5;
_yy = 22.5;

var _str = string(global.playerMoney);

draw_text(_xx + 1, _yy, _str);
draw_text(_xx - 1, _yy, _str);
draw_text(_xx, _yy + 1, _str);
draw_text(_xx, _yy - 1, _str);

draw_set_colour(c_white);
draw_text(_xx, _yy, _str);


// ==================================
// DRAW ITEM BOX
// ==================================

_xx = 8;
_yy = 24;

draw_sprite(sItemUIBox, 0, _xx, _yy);

if (global.playerHasAnyItems)
{
    draw_sprite(sItemUI, global.playerEquipped, _xx, _yy);

    if (global.playerAmmo[global.playerEquipped] != -1)
    {
        draw_set_font(fAmmo);
        draw_set_halign(fa_right);
        draw_set_valign(fa_bottom);
        draw_set_colour(c_white);

        draw_text(
            _xx + sprite_get_width(sItemUIBox) + 1,
            _yy + sprite_get_height(sItemUIBox) + 1,
            string(global.playerAmmo[global.playerEquipped])
        );
    }
}



// ==================================
// QUEST POPUP - COMPACT VERSION
// ==================================

if (room != rTitle && !global.gameOver)
{
    var _questText = "";
    var _showQuest = false;

    // Quest NPC dan Topi
    if (global.questStatus[? "TheHatQuest"] == 0)
    {
        _questText = "Berbicaralah dengan\nALEX di dalam rumah\nPRESS J UNTUK MENUTUP";
        _showQuest = true;
    }
    else if (global.questStatus[? "TheHatQuest"] == 1)
    {
        _questText = "Temukan topi di goa\nPRESS J UNTUK MENUTUP";
        _showQuest = true;
    }

	  // Quest Api
	if (global.treeQuestActive && !global.treeQuestComplete)
	{
	    _questText = "Padamkan api "
	               + string(global.treeFireCount)
	               + "/"
	               + string(global.treeFireTarget)
				   + "\nPRESS J UNTUK MENUTUP"

	    _showQuest = true;
	}

    // Popup terbuka
	if (_showQuest && questPanelVisible)
	{
	    var _scale = 0.40;   // sebelumnya 0.25 (besarkan dikit)
	    var _padX  = 8;      // padding kiri/kanan (geser teks ke kanan)
	    var _padY  = 12;      // padding atas/bawah
	    var _gap   = 3;      // jarak antara judul dan isi

	    draw_set_font(fText);
	    draw_set_halign(fa_left);
	    draw_set_valign(fa_top);

	    // Ukur teks supaya background pas
	    var _titleW = string_width("PETUNJUK:") * _scale;
	    var _titleH = string_height("PETUNJUK:") * _scale;
	    var _bodyW  = string_width(_questText) * _scale;
	    var _bodyH  = string_height(_questText) * _scale;

	    var _panelW = max(_titleW, _bodyW) + (_padX * 2);
	    var _panelH = _titleH + _gap + _bodyH + (_padY * 2);

	    var _panelX = RESOLUTION_W - _panelW - 6;
	    var _panelY = 6;

	    // Background
	    draw_sprite_stretched(
	        sTextBoxBg,
	        0,
	        _panelX,
	        _panelY,
	        _panelW,
	        _panelH
	    );

	    draw_set_colour(c_white);

	    // Judul
	    draw_text_transformed(
	        _panelX + _padX,
	        _panelY + _padY,
	        "PETUNJUK:",
	        _scale,
	        _scale,
	        0
	    );

	    // Isi quest
	    draw_text_transformed(
	        _panelX + _padX,
	        _panelY + _padY + _titleH + _gap,
	        _questText,
	        _scale,
	        _scale,
	        0
	    );
	}

    // Popup disembunyikan
    if (_showQuest && !questPanelVisible)
    {
        draw_set_font(fText);
        draw_set_halign(fa_right);
        draw_set_valign(fa_top);
        draw_set_colour(c_white);

        draw_text_transformed(
            RESOLUTION_W - 8,
            8,
            "J: PETUNJUK",
            0.5,
            0.5,
            0
        );
    }
}



// ==================================
// RESET ALIGNMENT
// ==================================

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);


// ==================================
// PAUSE SCREEN
// ==================================

if (global.gamePaused && !global.gameOver)
{
    draw_set_color(c_black);
    draw_set_alpha(0.75);

    draw_rectangle(
        0,
        0,
        RESOLUTION_W,
        RESOLUTION_H,
        false
    );

    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_font(fText);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_text(
        RESOLUTION_W * 0.5,
        RESOLUTION_H * 0.5,
        " ... Game Paused ... "
    );

    for (var i = 0; i < array_length(pauseOption); i++)
    {
        var _print = "";

        if (i == pauseOptionSelected)
        {
            _print += "> " + pauseOption[i] + " <";
        }
        else
        {
            _print += pauseOption[i];
            draw_set_alpha(0.7);
        }

        draw_text(
            RESOLUTION_W * 0.5,
            RESOLUTION_H * 0.5 + 18 + (i * 12),
            _print
        );

        draw_set_alpha(1.0);
    }
}


// ==================================
// GAME OVER SCREEN
// ==================================

if (global.gameOver)
{
    // Background
    draw_set_alpha(0.85);
    draw_set_color(c_black);

    draw_rectangle(
        0,
        0,
        RESOLUTION_W,
        RESOLUTION_H,
        false
    );

    draw_set_alpha(1);
    draw_set_color(c_white);

    draw_set_font(fText);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // Judul
    draw_set_color(c_black);

    draw_text(
        RESOLUTION_W * 0.5 + 1,
        RESOLUTION_H * 0.5 - 15 + 1,
        "GAME OVER"
    );

    draw_set_color(c_white);

    draw_text(
        RESOLUTION_W * 0.5,
        RESOLUTION_H * 0.5 - 15,
        "GAME OVER"
    );

    // Pesan
    draw_set_color(c_white);
    draw_set_alpha(0.7);

    draw_text(
        RESOLUTION_W * 0.5,
        RESOLUTION_H * 0.5 + 5,
        "Your journey has ended..."
    );

    draw_set_alpha(1);

    // Instruksi
    draw_text(
        RESOLUTION_W * 0.5,
        RESOLUTION_H * 0.5 + 30,
        "Press ENTER to return"
    );

    // Reset
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}
