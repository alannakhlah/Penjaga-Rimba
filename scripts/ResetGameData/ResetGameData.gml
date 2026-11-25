function ResetGameData()
{
    // Health dan uang
    global.playerHealthMax = 5.0;
    global.playerHealth = 5.0;
    global.playerMoney = 10;

    // Item
    global.playerHasAnyItems = false;
    global.playerEquipped = ITEM.BOMB;

    global.playerAmmo = array_create(ITEM.TYPE_COUNT, -1);
    global.playerItemUnlocked = array_create(ITEM.TYPE_COUNT, false);

    global.playerAmmo[ITEM.BOMB] = 0;
    global.playerAmmo[ITEM.BOW] = 0;

    // Posisi dan target
    global.targetRoom = -1;
    global.targetX = -1;
    global.targetY = -1;
    global.targetDirection = 0;

    // Item yang sedang diangkat
    global.iLifted = noone;

    // Quest
    ds_map_clear(global.questStatus);
    global.questStatus[? "TheHatQuest"] = 0;

    // Tree Fire Quest
    global.treeQuestActive = false;
    global.treeQuestComplete = false;
    global.treeFireCount = 0;
    global.treeFireTarget = 30;
    global.treePathOpen = false;

    // Api yang sudah dipadamkan
    ds_map_clear(global.extinguishedFires);
	
	// Reset Game State
global.gameOver = false;
global.gamePaused = false;
global.gameSaveSlot = 0;

// Reset Auto Heal
if (instance_exists(oGame))
{
    with (oGame)
    {
        healTimer = 0;
    }
}

    show_debug_message("All game data reset!");
}
