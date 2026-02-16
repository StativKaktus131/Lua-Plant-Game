require("src.plant")
require("src.util")
require("src.button")
Assets = require("src.sprites")
Anchor = require("src.anchor")

local plants = {}
local buttons = {}
local timer = 0
local days = 0

Cursor = 0
MousePos = {x=0,y=0}
CursorState = {
	Arrow = 1,
	Hand = 2,
	Seed = 3
}

local CURSOR_SCALE = 2
DAY_TIME = 3 -- time of day in seconds


function passDay ()
	days = days + 1
end

function setCursorState (cs)
	Cursor = cs
end

function drawCursor ()
	local currentCursor = Assets.cursors[Cursor]

	-- set empty cursor
	love.mouse.setCursor(love.mouse.newCursor("res/cursors/cur_empty.png", 0, 0))

	love.graphics.setColor(1.0, 1.0, 1.0)
	love.graphics.draw(currentCursor.img, MousePos.x - currentCursor.hotx * CURSOR_SCALE, MousePos.y - currentCursor.hoty * CURSOR_SCALE, 0, CURSOR_SCALE, CURSOR_SCALE)
end


function love.load ()
	love.window.setFullscreen(true)

	Width, Height, _ = love.window.getMode()
	local centerX = Width / 2
	local centerY = Height / 2

	for x = -1,1 do
		for y = -1,1 do
			table.insert(plants, Plant:new(centerX + x * 400, centerY + y * 200))
		end
	end

	table.insert(buttons, Button:new(Anchor.BottomRight, 0, 0, function ()
		setCursorState(CursorState.Seed)
	end))

	love.graphics.setDefaultFilter("nearest", "nearest", 1)

	Assets.load()
end

function love.update (dt)
	MousePos.x, MousePos.y = love.mouse.getPosition()

	local keepTimer = timer % DAY_TIME
	timer = timer + dt

	-- delta is smaller than zero
	if timer % DAY_TIME < keepTimer then
		passDay()
	end

	days = math.floor(timer / DAY_TIME)

	UForEach(plants, function (element) element:update(dt) end)
	UForEach(buttons, function (element) element:update(dt) end)

	-- check if mouse is over
	-- only check if not already seed

	if Cursor == CursorState.Seed then
		return
	end
	local isOver = false
	UForEach(plants, function (element)
		if UMouseOver(element.rect) then
			isOver = true
		end
	end)

	if isOver then
		setCursorState(CursorState.Hand)
	else
		setCursorState(CursorState.Arrow)
	end
end

function love.draw ()
	-- background
	love.graphics.setColor(1.0, 1.0, 1.0)
	love.graphics.rectangle("fill", 0, 0, Width, Height)

	UForEach(plants, function (element) element:draw() end)
	UForEach(buttons, function (element) element:draw() end)

	-- time scale
	local segments = 8
	local progress = ((timer % DAY_TIME) / DAY_TIME) - ((timer % DAY_TIME) / DAY_TIME) % (1/segments)
	love.graphics.setColor(0.0, 1.0, 0.0)
	love.graphics.arc("fill", 40, 40, 20, UToRadians(270), progress * TWO_PI + UToRadians(270), progress * segments)

	love.graphics.setColor(0.0, 0.0, 0.0)
	love.graphics.print(days, 10, 100)

	drawCursor()
end

function love.keypressed (key)
	
	-- escape quit
	if key == "escape" then
		love.event.quit(0)
	end
end

function love.mousepressed ()
	UForEach(plants, function (plant)
		if UMouseOver(plant.rect) then
			plant:mouseDown()
		end
	end)

	UForEach(buttons, function (btn)
		if UMouseOver(btn.rect) then
			btn.mouseDown()
		end
	end)
end