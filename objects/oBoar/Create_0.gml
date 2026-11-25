
event_inherited();

// Initial State
state = ENEMYSTATE.WANDER;

// Enemy Sprites
sprMove = sBoar;
sprAttack = sBoarAttack;
sprDie = sBoarDie;
sprHurt = sBoarHurt;

// Enemy Scripts
enemyScript[ENEMYSTATE.WANDER] = BoarWander;
enemyScript[ENEMYSTATE.CHASE] = BoarChase;
enemyScript[ENEMYSTATE.ATTACK] = BoarAttack;
enemyScript[ENEMYSTATE.HURT] = BoarHurt;
enemyScript[ENEMYSTATE.DIE] = BoarDie;

// Movement
boarWalkSpeed = 0.5;
boarRunSpeed = 0.8;
boarAttackRadius = 16;

// Random Patrol
boarPatrolRadius = 64;
boarWaitDuration = 45;
boarWait = 0;
boarMoving = false;

// Animation
boarAnimRow = -1;
boarHurtRow = -1;
boarDieRow = -1;

// Initial Destination
xTo = x;
yTo = y;

// Detection
aggroCheck = 0;
aggroCheckDuration = 5;


boarAttackStarted = false;
boarAttackStartFrame = 0;


// Drops
entityDropList = choose
(
	[oCoin, oCoin],
	[oCoin, oCoin],
	[oCoin, oCoin],
	[oCoin, oCoin],
	[oBombDrop],
    [oBombDrop],
	[oBombDrop],
	[oArrowDrop]
);

boarAttackStarted = false;
boarAttackStartFrame = 0;
boarAttackHit = false;
boarAttackRadius = 10;
