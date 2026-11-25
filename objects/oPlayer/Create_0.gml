state = PlayerStateFree;
stateAttck = AttackSlash;
hitByAttack = -1;
lastState = state;

collisionMap = layer_tilemap_get_id(layer_get_id("Col"));

image_speed = 0;
hSpeed = 0;
vSpeed = 0;
speedWalk = 1.5;
speedRoll = 2.5;
distanceRoll = 52;
distanceBonk = 8;
distanceBonkHeight = 6;
speedBonk = 0.8;
fireInteractRange = 24;
z = 0;
invulnerable = 0;
flash = 0;
flashShader = shWhiteFlash;

animationEndScript = -1;

spriteRoll = sPlayerRoll
spriteRun = sPlayerRun;
spriteIdle = sPlayer;
localFrame = 0;

if(global.targetX != -1)
{
	x = global.targetX;
	y = global.targetY;
	direction = global.targetDirection;
}

walkSoundTimer = 0;