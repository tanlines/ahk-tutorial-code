#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance
#Persistent

centerX := A_ScreenWidth/2
centerY := A_ScreenHeight/2

F1::
mousegetpos, centerX, centerY
ToolTip, New center,centerX, centerY
return

F2::
CoordMode, Pixel, Window
distance := 50
Loop, 10
{
	PixelSearch, FoundX, FoundY, % centerX-distance, % centerY-distance, % centerX+distance, % centerY+distance, 0x0000FF, 0, Fast RGB
	
	ToolTip, Top left,% centerX-distance,% centerY-distance
	Sleep, 500
	ToolTip, Bottom right, % centerX+distance, % centerY+distance
	Sleep, 500
	SetTimer, RemoveToolTip, -1000
	Random, rand, -10, 10
	FoundX += %rand%
	Random, rand, -10, 10
	FoundY += %rand%
	If (ErrorLevel = 0) {
		Click, %FoundX%, %FoundY% Left, 0
		Sleep, 120
		Click, %FoundX%, %FoundY% Left, 1
		return
	}
	distance += 50
}
return













F3::
CoordMode, Pixel, Window
Loop, 50
{
PixelSearch, FoundX, FoundY, % centerX-A_Index*20, % centerY-A_Index*20, % centerX+A_Index*20-1, % centerY+A_Index*20-1, 0x00FFFF, 0, Fast RGB
Random, rand, -10, 10
FoundX += %rand%
Random, rand, -10, 10
FoundY += %rand%
If (ErrorLevel = 0) {
	Click, %FoundX%, %FoundY% Left, 0
	Sleep, 120
	Click, %FoundX%, %FoundY% Left, 1
	return
}
}
return

F4::
CoordMode, Pixel, Window
Loop, 50
{
PixelSearch, FoundX, FoundY, % centerX-A_Index*20, % centerY-A_Index*20, % centerX+A_Index*20-1, % centerY+A_Index*20-1, 0xFF00FF, 0, Fast RGB
Random, rand, -10, 10
FoundX += %rand%
Random, rand, -10, 10
FoundY += %rand%
If (ErrorLevel = 0) {
	Click, %FoundX%, %FoundY% Left, 0
	Sleep, 120
	Click, %FoundX%, %FoundY% Left, 1
	return
}
}
return

F5::
CoordMode, Pixel, Window
Random, randd, 5, 7
If (ErrorLevel = 0) {
	Send, {LShift Down}
	Sleep, 140
	loop, %randd% {
		PixelSearch, FoundX, FoundY, 0, 0, 1920, 1080, 0x00FF00, 0, Fast RGB
		Random, rand, -10, 10
		FoundX += %rand%
		Random, rand, -10, 10
		FoundY += %rand%
		If (ErrorLevel = 0) {
			Random, slepe, 30, 60
			Click, %FoundX%, %FoundY% Left, 0
			Sleep, slepe
			Click, %FoundX%, %FoundY% Left, 1
		}
	}
	Sleep, 70
	Send, {LShift Up}
}
return

RemoveToolTip:
ToolTip
return