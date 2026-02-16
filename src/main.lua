require("src.plant")
require("src.util")
require("src.button")
Assets = require("src.sprites")

local plants = {}
local timer = 0
local days = 0

DAY_TIME = 3 -- time of day in seconds


function passDay ()
	days = days + 1
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

	love.graphics.setDefaultFilter("nearest", "nearest", 1)

	Assets.load()
	
end

function love.update (dt)
	local keepTimer = timer % DAY_TIME
	timer = timer + dt

	-- delta is smaller than zero
	if timer % DAY_TIME < keepTimer then
		passDay()
	end

	days = math.floor(timer / DAY_TIME)

	UForEach(plants, function (element) element:update(dt) end)

	-- check if mouse is over
	local isOver = false
	local mx, my = love.mouse.getPosition()
	UForEach(plants, function (element)
		if element:mouseOver(mx, my) then
			isOver = true
		end
	end)

	if isOver then
		love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
	else
		love.mouse.setCursor(love.mouse.getSystemCursor("arrow"))
	end
end

function love.draw ()
	-- background
	love.graphics.setColor(1.0, 1.0, 1.0)
	love.graphics.rectangle("fill", 0, 0, Width, Height)

	UForEach(plants, function (element) element:draw() end)

	-- time scale
	local segments = 8
	local progress = ((timer % DAY_TIME) / DAY_TIME) - ((timer % DAY_TIME) / DAY_TIME) % (1/segments)
	love.graphics.setColor(0.0, 1.0, 0.0)
	love.graphics.arc("fill", 40, 40, 20, UToRadians(270), progress * TWO_PI + UToRadians(270), progress * segments)

	love.graphics.setColor(0.0, 0.0, 0.0)
	love.graphics.print(days, 10, 100)
end

function love.keypressed (key)
	
	-- escape quit
	if key == "escape" then
		love.event.quit(0)
	end
end