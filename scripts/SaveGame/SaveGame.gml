
function SaveGame()
{
    // ==================================
    // CREATE SAVE MAP
    // ==================================

    var _map = ds_map_create();

    // Room terakhir
    _map[? "room"] = room;

    // ==================================
    // SIMPAN POSISI PLAYER TERAKHIR
    // ==================================

    var _player = instance_find(oPlayer, 0);

    if (instance_exists(_player))
    {
        _map[? "playerX"] = _player.x;
        _map[? "playerY"] = _player.y;
        _map[? "playerDirection"] = _player.direction;
    }
    else
    {
        // Cadangan jika player tidak ditemukan
        _map[? "playerX"] = global.targetX;
        _map[? "playerY"] = global.targetY;
        _map[? "playerDirection"] = global.targetDirection;
    }

    // Tetap simpan target untuk kompatibilitas
    _map[? "targetX"] = _map[? "playerX"];
    _map[? "targetY"] = _map[? "playerY"];
    _map[? "targetDirection"] = _map[? "playerDirection"];

    // ==================================
    // PLAYER DATA
    // ==================================

    _map[? "playerHealth"] = global.playerHealth;
    _map[? "playerHealthMax"] = global.playerHealthMax;
    _map[? "playerMoney"] = global.playerMoney;
    _map[? "playerItemUnlocked"] = global.playerItemUnlocked;
    _map[? "playerAmmo"] = global.playerAmmo;
    _map[? "playerEquipped"] = global.playerEquipped;
    _map[? "playerHasAnyItems"] = global.playerHasAnyItems;

    // ==================================
    // QUEST DATA
    // ==================================

    var _questMap = ds_map_create();

    ds_map_copy(_questMap, global.questStatus);
    ds_map_add_map(_map, "questStatus", _questMap);

    // ==================================
    // TREE FIRE QUEST
    // ==================================

    var _treeQuestMap = ds_map_create();

    _treeQuestMap[? "active"] = global.treeQuestActive;
    _treeQuestMap[? "complete"] = global.treeQuestComplete;
    _treeQuestMap[? "fireCount"] = global.treeFireCount;
    _treeQuestMap[? "fireTarget"] = global.treeFireTarget;
    _treeQuestMap[? "pathOpen"] = global.treePathOpen;

    ds_map_add_map(_map, "treeQuest", _treeQuestMap);

    // ==================================
    // EXTINGUISHED FIRES
    // ==================================

    var _extinguishedMap = ds_map_create();

    ds_map_copy(_extinguishedMap, global.extinguishedFires);

    ds_map_add_map(_map, "extinguishedFires", _extinguishedMap);

    // ==================================
    // CONVERT TO JSON
    // ==================================

    var _string = json_encode(_map);

    var _fileName = "save" + string(global.gameSaveSlot) + ".sav";

    SaveStringToFile(_fileName, _string);

    // ==================================
    // RECORD LAST SAVE SLOT
    // ==================================

    if (file_exists(_fileName))
    {
        var _lastFile = file_text_open_write("lastsave.txt");

        file_text_write_string(
            _lastFile,
            string(global.gameSaveSlot)
        );

        file_text_close(_lastFile);

        show_debug_message("Last save slot recorded!");
    }

    // Debug posisi
    show_debug_message(
        "PLAYER SAVED: "
        + string(_map[? "playerX"])
        + ", "
        + string(_map[? "playerY"])
    );

    ds_map_destroy(_map);

    show_debug_message("Game saved!");
}
