if (ticket == 0)
{
    // Simpan data dialog
    var _message = message;
    var _background = background;
    var _origin = originInstance;

// TAMBAHKAN INI
var _responses = responses;
var _responseScripts = responseScripts;

    // Buat objek dialog baru
    var _newText = instance_create_layer(
        x, y, "Instances", oText
    );

    // Pindahkan data dialog
    _newText.message = _message;
    _newText.background = _background;
    _newText.originInstance = _origin;
	
	// TAMBAHKAN INI
_newText.responses = _responses;
_newText.responseScripts = _responseScripts;
_newText.responseSelected = 0;

    // Hapus objek antrean
    instance_destroy();
}