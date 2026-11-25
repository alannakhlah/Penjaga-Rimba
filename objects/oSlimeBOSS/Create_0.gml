// Inherit the parent event
event_inherited();

state = ENEMYSTATE.WANDER;

//Enemy Sprites
sprMove = sSlimeBOSS;
sprAttack = sSlimeAttackBOSS;
sprDie = sSlimeDieBOSS;
sprHurt = sSlimeHurtBOSS;

//Enemy Scripts
enemyScript[ENEMYSTATE.WANDER] = SlimeWander;
enemyScript[ENEMYSTATE.CHASE] = SlimeChaseBOSS;
enemyScript[ENEMYSTATE.ATTACK] = SlimeAttack;
enemyScript[ENEMYSTATE.HURT] = SlimeHurt;
enemyScript[ENEMYSTATE.DIE] = SlimeBossDie;

entityDropList = choose
(
	[oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin,],
	[oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin,]
)
