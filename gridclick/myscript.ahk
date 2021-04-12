#SingleInstance, Force
indexes := [1,2,3,4,8,7,6,5,9,10,11,12,16,15,14,13,17,18,19,20,24,23,22,21,25,26,27,28]
myGrid := new Inventory()
myGrid.load()

return
#include OSRSInventory.ahk

1::
myGrid.clickPoints(indexes, True)
return

2::
msgbox, % myGrid.filledSlots() " slots filled"
return

3::
if (myGrid.slotFilled(28)) {
	msgbox, 28th slot is full
} else {
	msgbox, 28th slot is empty
}
return



