function RoomToAreaName (_room)
{
	switch (_room)
	{
		case rVillage: return "The Village"; break;
		case rForest: return "The Forest"; break;
		case rCave: return "The Cave"; break;
		case rShop: return "The Shop"; break;
		default: return "Unknown Area"; break;
	}

}