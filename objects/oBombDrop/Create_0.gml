// Inherit the parent event
event_inherited();

if (!global.playerItemUnlocked[collectScriptArg[0]])
{
    instance_create_layer(x, y, layer, oCoin);
    instance_destroy();
    exit;
}
