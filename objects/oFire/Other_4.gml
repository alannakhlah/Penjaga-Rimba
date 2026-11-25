
// Buat identitas api berdasarkan room dan posisinya
var _key = room_get_name(room)
    + "_" + string(x)
    + "_" + string(y);

// Jika api sudah pernah dipadamkan, hancurkan
if (ds_map_exists(global.extinguishedFires, _key))
{
    instance_destroy();
}
