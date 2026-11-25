
titleVisible = 0.0;
keyPressed = false;
slotsVisible = 0.0;

slotSelected = 0;
loadingStarted = false;

// Animasi karakter menu
menuPlayerImage = 0;
menuPlayerSpeed = 0.2;

// Default last save slot
lastSaveSlot = 0;

// Read last saved slot
if (file_exists("lastsave.txt"))
{
    var _file = file_text_open_read("lastsave.txt");

    var _savedSlot = real(file_text_read_string(_file));

    file_text_close(_file);

    if (_savedSlot >= 0 && _savedSlot <= 2)
    {
        lastSaveSlot = _savedSlot;
    }
}

// Credits
creditsOpen = false;
// Tutorial
tutorialOpen = false;