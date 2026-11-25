function PurchaseItem(_item, _amount, _cost)
{
	if (global.playerMoney >= _cost)
	{
		global.playerHasAnyItems = true;
		global.playerItemUnlocked[_item] = true;
		global.playerAmmo[_item] += _amount;
		global.playerMoney -= _cost;
		global.playerEquipped = _item;
		
		var _desc = "";
		switch (_item)
		{
			case ITEM.BOW: _desc ="Terimakasih\nDatang Kembali"; break;
			case ITEM.BOMB: _desc ="Terimakasih\nDatang Kembali"; break;
			default: _desc = "Deskripsi item tidak ditemukan!";break;
		}
		NewTextBox(_desc,1);
	}
	else
	{
		NewTextBox("Coin Tidak Cukup ... ",1);
	}
}