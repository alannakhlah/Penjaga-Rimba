
function ExtinguishFire(_fire)
{
    if (!instance_exists(_fire)) return;

    // Cegah api dihitung dua kali
    if (_fire.isExtinguished) return;

    _fire.isExtinguished = true;

    // Simpan identitas posisi api
    var _key = room_get_name(room)
        + "_" + string(_fire.x)
        + "_" + string(_fire.y);

    global.extinguishedFires[? _key] = true;

    // Hitung hanya jika misi aktif
    if (global.treeQuestActive && !global.treeQuestComplete)
    {
        global.treeFireCount++;

        if (global.treeFireCount >= global.treeFireTarget)
        {
            global.treeFireCount = global.treeFireTarget;
            global.treeQuestComplete = true;
            global.treePathOpen = true;
        }
    }

    // Hancurkan api
    with (_fire)
    {
        instance_destroy();
    }
}




function ActivateFireQuest()
{
    // Jika misi sudah selesai
    if (global.treeQuestComplete)
    {
        NewTextBox("Terima kasih! Semua api berhasil kamu padamkan!", 2);
        NewTextBox("Sekarang jalan menuju gua sudah aman.", 2);
    }

    // Jika misi sedang berjalan
    else if (global.treeQuestActive)
    {
        NewTextBox("Bagaimana? Apakah kamu sudah memadamkan api?", 2);

        NewTextBox(
            "Api yang berhasil dipadamkan: "
            + string(global.treeFireCount)
            + "/"
            + string(global.treeFireTarget),
            2
        );
    }

    // Jika misi belum dimulai
    else
    {
        NewTextBox("Ahhh, Akhirnya Ada Petualang! Aku membutuhkan bantuanmu.", 2);

        NewTextBox(
            "Saya mencoba sihir baru tapi nampaknya sihirnya lepas kendali yang membuat banyak pohon yang terbakar.",
            2
        );
		NewTextBox("Nanti saya akan bantu kamu untuk membuka pintu menuju Goa", 2);
        NewTextBox("jadi tolong padamkan semuanya!", 2);

        // Mulai misi
        global.treeQuestActive = true;
        global.treeQuestComplete = false;
        global.treeFireCount = 0;
    }
}