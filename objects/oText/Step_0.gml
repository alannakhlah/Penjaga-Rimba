lerpProgress += (1 - lerpProgress) / 50;
textProgress += global.textSpeed;


 // Text Typing Sound
var _currentChar = floor(textProgress);
var _messageLength = string_length(message);

if (_currentChar <= _messageLength)
{
    if (_currentChar >= typingSoundChar + 2)
    {
        typingSoundChar = _currentChar;

        var _char = string_char_at(message, _currentChar);

        if (_char != " " && _char != "\n" && _char != "")
        {
            audio_play_sound(sndTextTyping, 1, false);
        }
    }
}


x1 = lerp(x1,x1Target,lerpProgress)
x2 = lerp(x2,x2Target,lerpProgress)

//Cycle through responses
keyUp = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
keyDown = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
responseSelected += (keyDown - keyUp);
var _max = array_length_1d(responses)-1
var _min = 0;
if (responseSelected > _max) responseSelected = _min;
if (responseSelected < _min) responseSelected = _max;
// Response Move Sound
if (responses[0] != -1 && (keyUp || keyDown))
{
    audio_play_sound(sndResponseMove, 1, false);
}

if (keyboard_check_pressed(ord("E")))
{
    var _messageLength = string_length(message)
    if (textProgress >= _messageLength)
    {
        if (responses[0] != -1)
        {
            // Response Select Sound
            audio_play_sound(sndResponseSelect, 1, false);

            with (originInstance) DialogueResponses(other.responseScripts[other.responseSelected]);
        }
        else
        {
            // Dialogue Next Sound
            audio_play_sound(sndDialogueNext, 1, false);
        }
		
		
		
		
		instance_destroy();
		if (instance_exists(oTextQueued))
		{
		with (oTextQueued) ticket --;
		}
		else
		{
			with (oPlayer) state = lastState;
		}
	}
	else
	{
		if (textProgress > 2)
		{
			textProgress = _messageLength;
		}	
	}	
	
}	