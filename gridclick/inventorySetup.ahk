#SingleInstance, Force
indexes := [1,2,3,4,8,7,6,5,9,10,11,12,16,15,14,13,17,18,19,20,24,23,22,21,25,26,27,28]
myGrid := new Inventory()
return

#include OSRSInventory.ahk

1::
myGrid.clickPoints(indexes, True)
return

2::
Tooltip
MouseGetPos, topLeftX, topLeftY
Tooltip, Top left corner
return

3::
Tooltip
MouseGetPos, botRightX, botRightY
myGrid.setPoints(topLeftX, topLeftY,botRightX, botRightY)
Tooltip, Finished setting points
return

4::
Tooltip
myGrid.setEmptyInventoryColor()
myGrid.save()
Tooltip, Finished setting colors and saving
return

5::
Tooltip
msgbox, % myGrid.filledSlots() " slots filled"
return

6::
Tooltip
if (myGrid.slotFilled(28)) {
	msgbox, 28th slot is full
} else {
	msgbox, 28th slot is empty
}
return








