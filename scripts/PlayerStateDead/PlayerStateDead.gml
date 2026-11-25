
function PlayerStateDead()
{
    hSpeed = 0;
    vSpeed = 0;

    // Jika baru memasuki state mati
    if (sprite_index != sPlayerDie && sprite_index != sPlayerDead)
    {
        audio_play_sound(sndPlayerDie, 1, false);

        sprite_index = sPlayerDie;
        image_index = 0;
        image_speed = 0.7;
    }

    // Animasi kematian
    if (image_index + image_speed > image_number)
    {
        if (sprite_index == sPlayerDie)
        {
            image_speed = max(0, image_speed - 0.03);

            if (image_speed < 0.07)
            {
                image_index = 0;
                sprite_index = sPlayerDead;
                image_speed = 1.0;
            }
        }
        else
        {
            image_speed = 0;
            image_index = image_number - 1;

            // Aktifkan Game Over setelah animasi selesai
            global.gameOver = true;
            global.gamePaused = true;
        }
    }
}
