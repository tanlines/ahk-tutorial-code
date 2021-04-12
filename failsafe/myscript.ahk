#Persistent

SetTimer,expDropCheck,1000

loop {

	sleep, 2000
	msgbox, %A_TickCount%
}
return

#include AHKFailSafe.ahk