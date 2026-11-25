function FoxAttack()
{
    sprite_index = sprMove;

    // Berhenti sementara saat menyerang
    hSpeed = 0;
    vSpeed = 0;

    // Animasi Walk digunakan sebagai animasi serangan
    image_speed = 0;

    // Berikan damage satu kali
    if (instance_exists(target))
    {
        if (point_distance(x, y, target.x, target.y) <= enemyAttackRadius)
        {
            HurtPlayer(
                point_direction(x, y, target.x, target.y),
                enemyForceTouch,
                enemyDamageTouch
            );
        }
    }

    // Kembali mengejar setelah jeda
    stateTarget = ENEMYSTATE.CHASE;
    stateWaitDuration = 15;
    state = ENEMYSTATE.WAIT;
}



function FoxChase()
{
    // Pastikan target masih ada
    if (!instance_exists(target))
    {
        state = ENEMYSTATE.WANDER;
        foxAnimRow = -1;
        return;
    }

    // Cek jarak Player
    var _distance = point_distance(x, y, target.x, target.y);

    // Jika sudah dekat, mulai menyerang
    if (_distance <= enemyAttackRadius)
    {
        hSpeed = 0;
        vSpeed = 0;

        state = ENEMYSTATE.ATTACK;
        return;
    }

    // Jika Player terlalu jauh, kembali patrol
    if (_distance > enemyAggroRadius * 3)
    {
        state = ENEMYSTATE.WANDER;
        foxAnimRow = -1;
        return;
    }

    // Bergerak mengejar Player
    dir = point_direction(x, y, target.x, target.y);

    hSpeed = lengthdir_x(enemySpeed, dir);
    vSpeed = lengthdir_y(enemySpeed, dir);

    // Tentukan arah animasi
    var _newRow;

    if (abs(hSpeed) > abs(vSpeed))
    {
        _newRow = (hSpeed > 0) ? 18 : 12;
    }
    else
    {
        _newRow = (vSpeed > 0) ? 0 : 6;
    }

    // Reset frame jika arah berubah
    if (foxAnimRow != _newRow)
    {
        foxAnimRow = _newRow;
        image_index = _newRow;
    }

    sprite_index = sprMove;
    image_speed = 1;

    // Batasi frame sesuai arah animasi
    if (image_index < _newRow || image_index >= _newRow + 6)
    {
        image_index = _newRow;
    }

    // Periksa tabrakan
    if (EnemyTileCollision())
    {
        hSpeed = 0;
        vSpeed = 0;
    }
}

