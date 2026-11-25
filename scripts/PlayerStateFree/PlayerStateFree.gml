
function PlayerStateFree()
{

// Movement
hSpeed = lengthdir_x(inputMagnitude * speedWalk, inputDirection);
vSpeed = lengthdir_y(inputMagnitude * speedWalk, inputDirection);

PlayerCollision();

// Footsteps Sound
if (inputMagnitude != 0)
{
    if (walkSoundTimer <= 0)
    {
        audio_play_sound(sndWalk, 1, false);
        walkSoundTimer = 15;
    }
    else
    {
        walkSoundTimer--;
    }
}
else
{
    walkSoundTimer = 0;
}

// Update Sprite
var _oldSprite = sprite_index;

if (inputMagnitude != 0)
{
    direction = inputDirection;
    sprite_index = spriteRun;
}
else
{
    sprite_index = spriteIdle;
}

if (_oldSprite != sprite_index)
    localFrame = 0;

PlayerAnimateSprite();


// ==================================
// ATTACK / THROW
// ==================================

if (keyAttack)
{
    if (global.iLifted != noone)
    {
        // Jika membawa topi atau bom, lempar
        PlayerThrow();
    }
    else
    {
        // Jika tangan kosong, attack
        state = PlayerStateAttack;
        stateAttack = AttackSlash;
    }
}


// ==================================
// INTERACTION (E)
// ==================================

if (keyActivate)
{
    var _activateX = x + lengthdir_x(10, direction);
    var _activateY = y + lengthdir_y(10, direction);
    var _activateSize = 4;

    // Cek api
    var _fire = collision_rectangle(
        _activateX - _activateSize,
        _activateY - _activateSize,
        _activateX + _activateSize,
        _activateY + _activateSize,
        oFire,
        false,
        true
    );

    if (_fire != noone)
    {
        ExtinguishFire(_fire);
    }
    else
    {
        var _activateList = ds_list_create();

        activate = noone;

        var _entitiesFound = collision_rectangle_list(
            _activateX - _activateSize,
            _activateY - _activateSize,
            _activateX + _activateSize,
            _activateY + _activateSize,
            pEntity,
            false,
            true,
            _activateList,
            true
        );

        while (_entitiesFound > 0)
        {
            var _check = _activateList[| --_entitiesFound];

            if (_check != global.iLifted &&
                _check.entityActivateScript != -1)
            {
                activate = _check;
                break;
            }
        }

        ds_list_destroy(_activateList);

        // Interaksi entity
        if (activate != noone)
        {
            ScriptExecuteArray(
                activate.entityActivateScript,
                activate.entityActivateArgs
            );

            if (activate.entityNPC)
            {
                with (activate)
                {
                    direction = point_direction(
                        x, y, other.x, other.y
                    );

                    image_index = CARDINAL_DIR;
                }
            }
        }
    }
}


// ==================================
// ROLL (SPACE)
// ==================================

if (keyRoll)
{
    audio_play_sound(sndRoll, 1, false);

    state = PlayerStateRoll;
    moveDistanceRemaining = distanceRoll;
}


// ==================================
// USE EQUIPMENT (RIGHT CLICK)
// ==================================

if (keyItem &&
    global.playerHasAnyItems &&
    global.playerEquipped != ITEM.NONE)
{
    switch (global.playerEquipped)
    {
        case ITEM.BOMB:
            UseItemBomb();
        break;

        case ITEM.BOW:
            UseItemBow();
        break;

        case ITEM.HOOK:
            UseItemHook();
        break;
    }
}


// ==================================
// CHANGE EQUIPMENT (Q)
// ==================================

if (keyItemSelectUp && global.playerHasAnyItems)
{
    do
    {
        global.playerEquipped++;

        if (global.playerEquipped >= ITEM.TYPE_COUNT)
        {
            global.playerEquipped = 1;
        }

    }
    until (global.playerItemUnlocked[global.playerEquipped]);
}

}
