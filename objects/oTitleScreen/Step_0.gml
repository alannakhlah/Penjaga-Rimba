
 // =====================================
 // TITLE ANIMATION
 // =====================================

if (!keyPressed)
{
    titleVisible = min(1, titleVisible + 0.01);
}
else
{
    titleVisible = max(0, titleVisible - 0.01);
    slotsVisible = min(1, slotsVisible + 0.01);
}


// =====================================
// CREDITS
// =====================================

if (creditsOpen)
{
    if (keyboard_check_pressed(ord("E")) ||
        keyboard_check_pressed(vk_escape))
    {
        creditsOpen = false;
        audio_play_sound(sndResponseSelect, 0, false);
    }
}


// =====================================
// TUTORIAL
// =====================================

else if (tutorialOpen)
{
    if (keyboard_check_pressed(ord("E")) ||
        keyboard_check_pressed(vk_escape))
    {
        tutorialOpen = false;
        audio_play_sound(sndResponseSelect, 0, false);
    }
}


// =====================================
// MENU NAVIGATION
// =====================================

else
{
    var _keyUp = keyboard_check_pressed(vk_up)
              || keyboard_check_pressed(ord("W"));

    var _keyDown = keyboard_check_pressed(vk_down)
                || keyboard_check_pressed(ord("S"));

    if (_keyUp || _keyDown)
    {
        if (_keyUp)
        {
            slotSelected--;

            if (slotSelected < 0)
            {
                slotSelected = 4;
            }
        }

        if (_keyDown)
        {
            slotSelected++;

            if (slotSelected > 4)
            {
                slotSelected = 0;
            }
        }

        if (keyPressed)
        {
            audio_play_sound(sndResponseMove, 0, false);
        }
    }


    // =================================
    // SELECT MENU
    // =================================

    if (keyboard_check_pressed(ord("E"))
        && keyPressed && !loadingStarted)
    {
        audio_play_sound(sndResponseSelect, 0, false);

        switch (slotSelected)
        {
            // NEW GAME
            case 0:
            {
                loadingStarted = true;

                global.gameSaveSlot = 0;

                if (file_exists("save0.sav"))
                {
                    file_delete("save0.sav");
                }

                if (file_exists("lastsave.txt"))
                {
                    file_delete("lastsave.txt");
                }

                ResetGameData();

                RoomTransition(TRANS_TYPE.SLIDE, rVillage);
            }
            break;


            // CONTINUE
            case 1:
            {
                loadingStarted = true;

                global.gameSaveSlot = lastSaveSlot;

                if (!LoadGame(lastSaveSlot))
                {
                    global.gameSaveSlot = 0;

                    ResetGameData();

                    RoomTransition(TRANS_TYPE.SLIDE, rVillage);
                }
            }
            break;


            // TUTORIAL
            case 2:
            {
                tutorialOpen = true;
            }
            break;


            // CREDITS
            case 3:
            {
                creditsOpen = true;
            }
            break;


            // EXIT
            case 4:
            {
                loadingStarted = true;

                game_end();
            }
            break;
        }
    }
}


// =====================================
// FIRST KEY OPENS MENU
// =====================================

if (keyboard_check_pressed(vk_anykey))
{
    keyPressed = true;
}


// =====================================
// MENU CHARACTER ANIMATION
// =====================================

menuPlayerImage += menuPlayerSpeed;

if (menuPlayerImage >= 8)
{
    menuPlayerImage = 0;
}
	