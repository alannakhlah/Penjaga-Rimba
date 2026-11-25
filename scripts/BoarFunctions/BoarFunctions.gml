function BoarWander()
{
    sprite_index = sprMove;

    // Random Patrol
    if (!boarMoving)
    {
        hSpeed = 0;
        vSpeed = 0;

        image_speed = 0;

        // Pertahankan frame terakhir saat berhenti
        boarWait++;

        if (boarWait >= boarWaitDuration)
        {
            boarWait = 0;

            // Pilih arah dan jarak tujuan secara acak
            var _dir = irandom(359);
            var _distance = random(boarPatrolRadius);

            xTo = xstart + lengthdir_x(_distance, _dir);
            yTo = ystart + lengthdir_y(_distance, _dir);

            boarMoving = true;
        }
    }
    else
    {
        var _distanceToGo = point_distance(x, y, xTo, yTo);

        if (_distanceToGo <= boarWalkSpeed)
        {
            x = xTo;
            y = yTo;

            hSpeed = 0;
            vSpeed = 0;

            boarMoving = false;
            image_speed = 0;
        }
        else
        {
            // Hitung gerakan
            dir = point_direction(x, y, xTo, yTo);

            hSpeed = lengthdir_x(boarWalkSpeed, dir);
            vSpeed = lengthdir_y(boarWalkSpeed, dir);

            // Tentukan arah animasi
            var _newRow;

            if (abs(hSpeed) > abs(vSpeed))
            {
                if (hSpeed > 0)
                {
                    _newRow = 18; // Right
                }
                else
                {
                    _newRow = 12; // Left
                }
            }
            else
            {
                if (vSpeed > 0)
                {
                    _newRow = 0; // Down
                }
                else
                {
                    _newRow = 6; // Up
                }
            }

            // Reset animasi jika arah berubah
            if (boarAnimRow != _newRow)
            {
                boarAnimRow = _newRow;
                image_index = _newRow;
            }

			 image_speed = 1;

			// Batasi frame sesuai arah animasi
			if (image_index < _newRow || image_index >= _newRow + 6)
			{
			    image_index = _newRow;
			}
            // Move and check collision
            if (EnemyTileCollision())
            {
                boarMoving = false;
                xTo = x;
                yTo = y;
                image_speed = 0;
            }
        }
    }

    // Check Player Detection
    if (++aggroCheck >= aggroCheckDuration)
    {
        aggroCheck = 0;

        if (instance_exists(oPlayer))
        {
            if (point_distance(x, y, oPlayer.x, oPlayer.y)
            <= enemyAggroRadius)
            {
                target = oPlayer;
                state = ENEMYSTATE.CHASE;
            }
        }
    }
}



function BoarChase()
{
    // Pastikan target masih ada
    if (!instance_exists(target))
    {
        state = ENEMYSTATE.WANDER;
        boarMoving = false;
        boarAnimRow = -1;
        return;
    }

    // Cek jarak Player
    var _distance = point_distance(x, y, target.x, target.y);

	// Jika sudah dekat, mulai menyerang
	if (_distance <= boarAttackRadius)
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
        boarMoving = false;
        boarWait = 0;
        boarAnimRow = -1;
        return;
    }

    // Bergerak mengejar Player
    dir = point_direction(x, y, target.x, target.y);

    hSpeed = lengthdir_x(boarRunSpeed, dir);
    vSpeed = lengthdir_y(boarRunSpeed, dir);

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
    if (boarAnimRow != _newRow)
    {
        boarAnimRow = _newRow;
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




function BoarAttack()
{
    // Mulai animasi serangan
    if (!boarAttackStarted)
    {
        hSpeed = 0;
        vSpeed = 0;

        sprite_index = sprAttack;
        image_speed = 1;

        // Reset damage setiap serangan baru
        boarAttackHit = false;

        // Tentukan arah serangan
        var _dx = 0;
        var _dy = 0;

        if (instance_exists(target))
        {
            _dx = target.x - x;
            _dy = target.y - y;
        }
        else
        {
            _dx = lengthdir_x(1, dir);
            _dy = lengthdir_y(1, dir);
        }

        // Tentukan frame awal
        if (abs(_dx) > abs(_dy))
        {
            boarAttackStartFrame = (_dx > 0) ? 15 : 10;
        }
        else
        {
            boarAttackStartFrame = (_dy > 0) ? 0 : 5;
        }

        image_index = boarAttackStartFrame;

        boarAttackStarted = true;
    }
    else
    {
        hSpeed = 0;
        vSpeed = 0;

        // Berikan damage pada frame ke-3
        if (image_index >= boarAttackStartFrame + 2 && !boarAttackHit)
        {
            if (instance_exists(target))
            {
                if (point_distance(x, y, target.x, target.y) <= boarAttackRadius + 6)
                {
                    with (target)
                    {
                        HurtPlayer(
                            point_direction(other.x, other.y, x, y),
                            other.enemyForceTouch,
                            other.enemyDamageTouch
                        );
                    }
                }
            }

            boarAttackHit = true;
        }

        // Animasi selesai setelah 5 frame
        if (image_index >= boarAttackStartFrame + 4)
        {
            image_speed = 0;

            boarAttackStarted = false;

            if (instance_exists(target))
            {
                state = ENEMYSTATE.CHASE;
            }
            else
            {
                state = ENEMYSTATE.WANDER;
            }
        }
    }
}



function BoarHurt()
{
    sprite_index = sprHurt;

    // Hitung jarak knockback
    var _distanceToGo = point_distance(x, y, xTo, yTo);

    if (_distanceToGo > enemySpeed)
    {
        // Gerakkan Boar saat terkena serangan
        image_speed = 1;

        dir = point_direction(x, y, xTo, yTo);

        hSpeed = lengthdir_x(enemySpeed, dir);
        vSpeed = lengthdir_y(enemySpeed, dir);

        // Tentukan arah animasi Hurt
        var _newRow;

        if (abs(hSpeed) > abs(vSpeed))
        {
            _newRow = (hSpeed > 0) ? 12 : 8;
        }
        else
        {
            _newRow = (vSpeed > 0) ? 0 : 4;
        }

        // Reset frame jika arah berubah
        if (boarHurtRow != _newRow)
        {
            boarHurtRow = _newRow;
            image_index = _newRow;
        }

        // Batasi animasi 4 frame sesuai arah
        if (image_index < _newRow || image_index >= _newRow + 4)
        {
            image_index = _newRow;
        }

        // Tabrakan dengan dinding
        if (EnemyTileCollision())
        {
            xTo = x;
            yTo = y;
        }
    }
    else
    {
        // Knockback selesai
        x = xTo;
        y = yTo;

        hSpeed = 0;
        vSpeed = 0;

        image_speed = 0;
        boarHurtRow = -1;

        // Kembali ke state sebelumnya
        if (statePrevious != ENEMYSTATE.ATTACK)
        {
            state = statePrevious;
        }
        else
        {
            state = ENEMYSTATE.CHASE;
        }
    }
}




function BoarDie()
{
    sprite_index = sprDie;
    image_speed = 1;

    // Boar tidak bergerak saat animasi kematian
    hSpeed = 0;
    vSpeed = 0;

    // Tentukan arah animasi kematian
    var _dieRow = boarDieRow;

    // Jika arah belum ditentukan, gunakan arah terakhir
    if (_dieRow == -1)
    {
        if (abs(dir) <= 45 || abs(dir) >= 315)
        {
            _dieRow = 18; // Right
        }
        else if (dir > 45 && dir < 135)
        {
            _dieRow = 0; // Down
        }
        else if (dir >= 135 && dir <= 225)
        {
            _dieRow = 12; // Left
        }
        else
        {
            _dieRow = 6; // Up
        }

        boarDieRow = _dieRow;
        image_index = _dieRow;
    }

    // Batasi animasi pada 6 frame sesuai arah
    if (image_index < _dieRow || image_index >= _dieRow + 6)
    {
        image_index = _dieRow;
    }

    // Hapus Boar setelah animasi selesai
    if (image_index >= _dieRow + 5)
    {
        if (image_index >= _dieRow + 5)
        {
            instance_destroy();
        }
    }
}
