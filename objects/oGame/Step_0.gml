// Auto Heal System
if (!global.gamePaused)
{
    // Hanya menghitung waktu jika HP belum penuh
    if (global.playerHealth < global.playerHealthMax)
    {
        healTimer++;

        // Heal setiap 60 detik
        if (healTimer >= healInterval)
        {
            global.playerHealth = min(
                global.playerHealth + 1,
                global.playerHealthMax
            );

            healTimer = 0;
        }
    }
    else
    {
        // Reset timer jika HP penuh
        healTimer = 0;
    }
}