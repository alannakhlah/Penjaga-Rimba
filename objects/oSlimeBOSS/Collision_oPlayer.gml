if (state == ENEMYSTATE.ATTACK)
{
    HurtPlayer(
        point_direction(x, y, oPlayer.x, oPlayer.y),
        enemyForceTouch,
        enemyDamageTouch
    );
}