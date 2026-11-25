function DialogueResponses()
{
    switch(argument0)
    {
        case 0:
            break;

        case 1:
            NewTextBox("You gave response A!", 1);
            break;

        case 2: NewTextBox("You gave response B! Any further response?",1,["3:Yes!", "0:No."]);
			break;

        case 3: NewTextBox("Thanks for your responses!", 0);
            break;

		case 4:
		{
			NewTextBox("Terimakasih!", 2);
			NewTextBox("Sepertinya aku meninggalkannya jauh didalam gua yang berada di hutan!", 2);
			global.questStatus[? "TheHatQuest"] = 1;

		}break;
	
		case 5: NewTextBox(":(",2);
		break;
		
		case 6: PurchaseItem(activate.item, activate.itemAmount, activate.itemCost); break;

        default:
            break;
    }
}