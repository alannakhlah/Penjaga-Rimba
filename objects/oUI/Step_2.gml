
if (room == rTitle)
{
    visible = false;
}
else
{
    visible = true;
}

// ==================================
// QUEST POPUP TOGGLE
// ==================================

if (!global.gamePaused && !global.gameOver && room != rTitle)
{
    if (keyboard_check_pressed(ord("J")))
    {
        questPanelVisible = !questPanelVisible;
        audio_play_sound(sndResponseSelect, 0, false);
    }
}

// ==================================
// GAME OVER INPUT
// ==================================

if (global.gameOver)
{
    if (keyboard_check_pressed(vk_enter) ||
        keyboard_check_pressed(vk_space))
    {
        audio_play_sound(sndResponseSelect, 0, false);

        // Hapus save aktif
        var _saveFile = "save" + string(global.gameSaveSlot) + ".sav";

        if (file_exists(_saveFile))
        {
            file_delete(_saveFile);
        }

        // Hapus catatan save terakhir
        if (file_exists("lastsave.txt"))
        {
            file_delete("lastsave.txt");
        }

        // Reset status permainan
        global.gameOver = false;
        global.gamePaused = false;

        // Kembali ke menu utama
        room_goto(rTitle);
    }
}


// ==================================
// PAUSE MENU INPUT
// ==================================

else if (global.gamePaused)
{
    keyUp = keyboard_check_pressed(vk_up) ||
            keyboard_check_pressed(ord("W"));

    keyDown = keyboard_check_pressed(vk_down) ||
              keyboard_check_pressed(ord("S"));

    if (keyUp || keyDown)
    {
        pauseOptionSelected += (keyDown - keyUp);

        if (pauseOptionSelected >= array_length(pauseOption))
            pauseOptionSelected = 0;

        if (pauseOptionSelected < 0)
            pauseOptionSelected = array_length(pauseOption) - 1;

        audio_play_sound(sndResponseMove, 0, false);
    }

    keyActivate = keyboard_check_pressed(ord("E"));

    if (keyActivate)
    {
        audio_play_sound(sndResponseSelect, 0, false);

        switch (pauseOptionSelected)
        {
            case 0:
            {
                global.gamePaused = false;

                with (all)
                {
                    image_speed = gamePausedImageSpeed;
                }
            }
            break;

            case 1:
            {
                with (oGame) instance_destroy();

                SaveGame();
                game_restart();
            }
            break;

            case 2:
            {
                SaveGame();
                game_end();
            }
            break;
        }
    }
}
