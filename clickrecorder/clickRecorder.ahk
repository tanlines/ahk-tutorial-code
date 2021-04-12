#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Client
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1

ToolTip, How to use`nPress F5 to toggle recording`nPress F6 to playback,0,0
SetTimer, RemoveToolTip, -10000
points := []
recording := False
return

F5::
recording := !recording
MouseGetPos, currx, curry
if (recording) {
	points := []
	ToolTip, Recording!,%currx%,%curry%
} else {
	ToolTip, Stopped recording,%currx%,%curry%
}
return

~LButton::
if (!recording) {
	return
}
MouseGetPos, currx, curry
points.push({"x":currx,"y":curry})
ToolTip, Added point,%currx%,%curry%
return

F6::
For index, p In points
{
	MouseClick,, p.x, p.y
	Sleep, 100
}
return

Esc::
ExitApp
return


RemoveToolTip:
ToolTip
return