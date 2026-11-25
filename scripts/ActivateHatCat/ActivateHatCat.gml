function ActivateHatCat()
{
	var _hasHat = (global.iLifted != noone) && (global.iLifted.object_index == oHat);
	switch (global.questStatus[? "TheHatQuest"])
	{
		case 0: //not started
		{
			//player might have brought the hat back anyway
			if (_hasHat)
			{
				//complete quest
				NewTextBox("Wah, kamu menemukan topiku bahkan tanpa aku memintamu!",2);
				NewTextBox("Anda benar-benar seorang pahlawan sejati!",2);
				global.questStatus[? "TheHatQuest"] = 2;
				with (oQuestNPC) sprite_index = sQuestieHat;
				with (oHat) instance_destroy();
				global.iLifted = noone;
				with (oPlayer)
				{
					spriteIdle = sPlayer;
					spriteRun = sPlayerRun;
				}
			}
			else
			{
				NewTextBox("Halo! Kamu tampak seperti petualang yang pemberani! \nApalagi dengan jubah itu.",2)
				NewTextBox("Bisakah kamu membantu saya menemukan topi saya yang hilang?", 2, 
				["4:Tentu saja!","5:Tidak, saya sibuk"])
			}
			

		}break;
		
		case 1: //quest in progress
		{
			if (_hasHat)
			{
				//complete quest
				NewTextBox("Wah, kamu menemukan topiku!",2);
				NewTextBox("Anda benar-benar seorang pahlawan sejati!",2);
				global.questStatus[? "TheHatQuest"] = 2;
				with (oQuestNPC) sprite_index = sQuestieHat;
				with (oHat) instance_destroy();
				global.iLifted = noone;
				with (oPlayer)
				{
					spriteIdle = sPlayer;
					spriteRun = sPlayerRun;
				}
			}
			else
			{
				//clue reminder
				NewTextBox("Sepertinya aku meninggalkan topiku jauh didalam gua menyeramkan yang terletak di suatu tempat di dalam hutan.",2);
				NewTextBox("Anda mungkin memerlukan beberapa barang untuk sampai ke sana!",2);
			}

		}break;
		
		case 2: //quest already completed
		{
			NewTextBox("Sekali lagi terimakasih!",2);
		} break;
	}
	

}