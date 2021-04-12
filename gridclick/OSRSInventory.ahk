#include random.ahk

Class Inventory {
	static cols := 4, rows := 7, fileName := "myGrid.txt"
	points := []
	topLeftX := 0,topLeftY := 0,botRightX := 0,botRightY := 0
	
	__New(topLeftX := 1612,topLeftY := 615,botRightX := 1799,botRightY := 941)
    {
		this.setPoints(topLeftX,topLeftY,botRightX,botRightY)
    }
	
	setPoints(topLeftX,topLeftY,botRightX,botRightY) {
		this.topLeftX := topLeftX
	    this.topLeftY := topLeftY
	    this.botRightX := botRightX
	    this.botRightY := botRightY
		this.points := []
		colSize := (botRightX - topLeftX) / (this.cols - 1)
		rowSize := (botRightY - topLeftY) / (this.rows - 1)
		startX := topLeftX
		startY := topLeftY
		loop % this.rows {
			loop % this.cols {
				this.points.push({"x":startX,"y":startY,"color":""})
				startX += colSize
			}
			startY += rowSize
			startX := topLeftX
		}
	}
	
	setEmptyInventoryColor() {
		local pointColor
		for index, point in this.points {
			x := point.x
			y := point.y
			PixelGetColor pointColor, %x%, %y%
			point.color := pointColor
		}
	}
	
	slotFilled(slot) {
		point := this.points[slot]
		x := point.x
		y := point.y
		PixelGetColor pointColor, %x%, %y%
		return pointColor != point.color
	}
	
	filledSlots() {
		local count
		count := 0
		for index, point in this.points
		{
			if (this.slotFilled(index)) {
				count += 1
			}
		}
		return count
	}
	
	clickPoints(indexes, shiftDrop := False) {
		local pointColor
		Tooltip
		if (shiftDrop) {
			Send, {Shift down}
		}
		for _, number in indexes
		{
			point := this.points[number]
			x := point.x
			y := point.y
			PixelGetColor pointColor, %x%, %y%
			x := point.x + target_random(-10, 0, 10)
			y := point.y + target_random(-10, 0, 10)
			if (pointColor != point.color) {
				Click, %x%, %y%
			}
		}
		if (shiftDrop) {
			Send, {Shift up}
		}
	}
	
	save() {
		IniWrite, % this.topLeftX, % Inventory.fileName, bounds, topLeftX
		IniWrite, % this.topLeftY, % Inventory.fileName, bounds, topLeftY
		IniWrite, % this.botRightX, % Inventory.fileName, bounds, botRightX
		IniWrite, % this.botRightY, % Inventory.fileName, bounds, botRightY
		for index, point in this.points {
			IniWrite, % point.x, % Inventory.fileName, % index, x
			IniWrite, % point.y, % Inventory.fileName, % index, y
			IniWrite, % point.color, % Inventory.fileName, % index, color
		}
	}
	
	load() {
		local tempX, tempY, tempColor
		IniRead, tempTopLeftX, % Inventory.fileName, bounds, topLeftX
		IniRead, tempTopLeftY, % Inventory.fileName, bounds, topLeftY
		IniRead, tempBotRightX, % Inventory.fileName, bounds, botRightX
		IniRead, tempBotRightY, % Inventory.fileName, bounds, botRightY
		this.topLeftX := tempTopLeftX
		this.topLeftY := tempTopLeftY
		this.botRightX := tempBotRightX
		this.botRightY := tempBotRightY
		this.setPoints(topLeftX,topLeftY,botRightX,botRightY)
		for index, point in this.points {
			IniRead, tempX, % Inventory.fileName, % index, x
			IniRead, tempY, % Inventory.fileName, % index, y
			IniRead, tempColor, % Inventory.fileName, % index, color
			point.x := tempX
			point.y := tempY
			point.color := tempColor
		}
	}
}








