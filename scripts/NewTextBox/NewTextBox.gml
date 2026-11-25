function NewTextBox(){
var _obj;
if (instance_exists(oText)) _obj = oTextQueued; else _obj = oText;
with (instance_create_layer(0,0, "Instances",_obj))
{
	message = argument[0];
	if (instance_exists(other)) originInstance = other.id else originInstance = noone;
	if (argument_count > 1) background = argument[1]; else background = 1;
	if (argument_count > 2)
	{
		
// Trim markers from responses
responses = array_create(array_length(argument[2]));

array_copy(
    responses,
    0,
    argument[2],
    0,
    array_length(argument[2])
);

responseScripts = array_create(array_length(responses), -1);

for (var i = 0; i < array_length(responses); i++)
{
    var _markerPosition = string_pos(":", responses[i]);

    if (_markerPosition > 1)
    {
        var _scriptText = string_copy(
            responses[i],
            1,
            _markerPosition - 1
        );

        responseScripts[i] = real(_scriptText);

        responses[i] = string_delete(
            responses[i],
            1,
            _markerPosition
        );
    }
}

	}

else
{
responses = [-1];
responseScripts = [-1];	
}
}

with (oPlayer)
{
	if (state != PlayerStateLocked)
	{
		lastState = state;
		state = PlayerStateLocked;

	}
}


}