
function LoadGame(_slot)
{
    var _file = "save" + string(_slot) + ".sav";

    if (!file_exists(_file))
    {
        show_debug_message("No save in this slot");
        return false;
    }

    // ==================================
    // LOAD JSON
    // ==================================

    var _json = LoadJSONFromFile(_file);

    if (is_undefined(_json) || !ds_exists(_json, ds_type_map))
    {
        show_debug_message("Failed to decode save data");
        return false;
    }

    global.gameSaveSlot = _slot;

    // ==================================
    // PLAYER DATA
    // ==================================

    global.playerHealth = _json[? "playerHealth"];
    global.playerHealthMax = _json[? "playerHealthMax"];
    global.playerMoney = _json[? "playerMoney"];

    global.playerEquipped = _json[? "playerEquipped"];
    global.playerHasAnyItems = _json[? "playerHasAnyItems"];

    // ==================================
    // LOAD LAST PLAYER POSITION
    // ==================================

    // Gunakan koordinat terbaru jika tersedia
    // Jika save lama, gunakan targetX dan targetY

    if (ds_map_exists(_json, "playerX"))
    {
        global.targetX = _json[? "playerX"];
        global.targetY = _json[? "playerY"];
    }
    else
    {
        global.targetX = _json[? "targetX"];
        global.targetY = _json[? "targetY"];
    }

    // Load arah hadap player
    if (ds_map_exists(_json, "playerDirection"))
    {
        global.targetDirection = _json[? "playerDirection"];
    }
    else if (ds_map_exists(_json, "targetDirection"))
    {
        global.targetDirection = _json[? "targetDirection"];
    }
    else
    {
        global.targetDirection = 0;
    }

    show_debug_message(
        "PLAYER POSITION LOADED: "
        + string(global.targetX)
        + ", "
        + string(global.targetY)
    );

    // ==================================
    // LOAD ITEMS
    // ==================================

    for (var i = 0; i < ITEM.TYPE_COUNT; i++)
    {
        global.playerItemUnlocked[i] =
            _json[? "playerItemUnlocked"][| i];

        global.playerAmmo[i] =
            _json[? "playerAmmo"][| i];
    }

    // ==================================
    // LOAD QUEST
    // ==================================

    ds_map_clear(global.questStatus);

    ds_map_copy(
        global.questStatus,
        _json[? "questStatus"]
    );

    // ==================================
    // LOAD TREE FIRE QUEST
    // ==================================

    if (ds_map_exists(_json, "treeQuest"))
    {
        var _treeQuestMap = _json[? "treeQuest"];

        global.treeQuestActive = _treeQuestMap[? "active"];
        global.treeQuestComplete = _treeQuestMap[? "complete"];
        global.treeFireCount = _treeQuestMap[? "fireCount"];
        global.treeFireTarget = _treeQuestMap[? "fireTarget"];
        global.treePathOpen = _treeQuestMap[? "pathOpen"];
    }

    // ==================================
    // LOAD EXTINGUISHED FIRES
    // ==================================

    ds_map_clear(global.extinguishedFires);

    if (ds_map_exists(_json, "extinguishedFires"))
    {
        ds_map_copy(
            global.extinguishedFires,
            _json[? "extinguishedFires"]
        );
    }

    // ==================================
    // GET SAVED ROOM
    // ==================================

    var _savedRoom = _json[? "room"];

    ds_map_destroy(_json);

    // ==================================
    // GO TO SAVED ROOM
    // ==================================

    RoomTransition(TRANS_TYPE.SLIDE, _savedRoom);

    show_debug_message("Game loaded successfully!");

    return true;
}


// ==================================
// LOAD JSON FROM FILE
// ==================================

function LoadJSONFromFile(_filename)
{
    if (!file_exists(_filename))
    {
        return undefined;
    }

    var _buffer = buffer_load(_filename);

    if (_buffer == -1)
    {
        return undefined;
    }

    var _string = buffer_read(_buffer, buffer_string);

    buffer_delete(_buffer);

    return json_decode(_string);
}
