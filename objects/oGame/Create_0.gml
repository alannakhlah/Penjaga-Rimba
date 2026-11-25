/// @desc Initialise & Globals
randomize();
global.gameSaveSlot = 0;

// Data api yang sudah dipadamkan
global.extinguishedFires = ds_map_create();


global.gamePaused = false;
global.gameOver = false;
global.textSpeed = .75;
global.targetRoom = -1;
global.targetX = -1;
global.targetY = -1;
global.targetDirection = 0;
global.iLifted = noone;
global.playerHealthMax = 5.0;
global.playerHealth = 5.0;
// Auto Heal System
healTimer = 0;
healInterval = room_speed * 7; // 60 detik
global.playerMoney = 10;
//Items
global.playerHasAnyItems = false;
global.playerEquipped = ITEM.BOMB;
global.playerAmmo = array_create(ITEM.TYPE_COUNT, -1);
global.playerItemUnlocked = array_create(ITEM.TYPE_COUNT, false);
global.playerAmmo[ITEM.BOMB]=0;
global.playerAmmo[ITEM.BOW]=0;


global.questStatus = ds_map_create();
global.questStatus[? "TheHatQuest"] = 0;


global.iCamera = instance_create_layer(0,0,layer,oCamera); 
global.iUI = instance_create_layer(0,0,layer,oUI); 

global.treeQuestActive = false;
global.treeQuestComplete = false;

global.treeFireCount = 0;
global.treeFireTarget = 30;

global.treePathOpen = false;

surface_resize(application_surface, RESOLUTION_W, RESOLUTION_H);

room_goto(ROOM_START);




// Music Manager
musicHandle = -1;
musicType = "";
