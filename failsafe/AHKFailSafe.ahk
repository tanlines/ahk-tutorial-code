;By Nom
;https://www.youtube.com/watch?v=x6-YcHGztzU

expDropCheck:
expCheckFunction()
return

expCheckFunction() {
	static expDropColor := "0x4DC34D"
	static lastExp := A_TickCount
	PixelSearch, x, y, 0, 0, % A_ScreenWidth/4, % A_ScreenHeight/4, expDropColor , 5, Fast RGB
	if (ErrorLevel = 0) {
		lastExp := A_TickCount
		Tooltip, You gained exp!, %x%, %y%
		SetTimer,RemoveToolTip,-1000
	} else if (A_TickCount - lastExp > 10000) {
		Tooltip, No exp gained in the last 10 seconds
		Sleep, 5000
		ExitApp
	}
}

RemoveToolTip:
Tooltip
return