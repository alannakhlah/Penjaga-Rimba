x1 = RESOLUTION_W/2;
y1 = RESOLUTION_H-70;
x2 = RESOLUTION_W/2;
y2 = RESOLUTION_H;

x1Target = 0;
x2Target = RESOLUTION_W;

lerpProgress = 0;
textProgress = 0;

responseSelected = 0;

responses = [-1];
responseScripts = [-1];

typingSoundChar = 0;
// Dialogue Start Sound
audio_play_sound(sndDialogueNext, 1, false);