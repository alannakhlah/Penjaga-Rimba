/// @desc Pause the Game
if (keyboard_check_pressed(vk_escape) ) && (oUI.visible == true)
{
	global.gamePaused = !global.gamePaused;

	if (global.gamePaused)
	{
		with (all)
		{
			gamePausedImageSpeed = image_speed;
			image_speed = 0;
		}
	}
	else
	{
		with (all)
		{
			image_speed = gamePausedImageSpeed;
		}
	}
}



// Music Manager
var _wantedMusic = "";

if (room == rTitle)
    _wantedMusic = "menu";
else if (room == rVillage || room == rForest || room == rShop)
    _wantedMusic = "overworld";
else if (room == rCave)
    _wantedMusic = "cave";

if (_wantedMusic != musicType)
{
    // Hentikan musik sebelumnya
    if (musicHandle != -1)
    {
        audio_stop_sound(musicHandle);
        musicHandle = -1;
    }

    // Putar musik sesuai area
    if (_wantedMusic == "menu")
        musicHandle = audio_play_sound(sndMenu, 0, true);
    else if (_wantedMusic == "overworld")
        musicHandle = audio_play_sound(musOverworld, 0, true);
    else if (_wantedMusic == "cave")
        musicHandle = audio_play_sound(musCave, 0, true);

    musicType = _wantedMusic;
}
