require("sprites")

-- size in pixels
local plantSize = 128


-- Plant State will dictate sprite position
PlantState = {
	Empty = 0,
	Seedling = 1,
	Small = 2,
	Grown = 3,
	Fruit = 4
}

-- Plant Object
Plant = {
	x = 0,
	y = 0,
	state = PlantState.Empty,
	rect = {}
}


-- creates a new plant object at position 'x' and 'y'
function Plant:new (x, y)
	local ret = {
		x = x,
		y = y,
		state = PlantState.Empty,
		rect = {x - plantSize / 2, y - plantSize / 2, plantSize, plantSize}
	}

	self.__index = self
	setmetatable(ret, self)
	return ret
end

-- function will be called when a day passes
function Plant:passDay ()
	
end

function Plant:update (dt)
	
end

function Plant:draw ()
	-- set clear color to white, so sprite wont be altered
	love.graphics.setColor(1.0, 1.0, 1.0)
	
	local w, _ = IMG_POT:getDimensions()
	local scalar = plantSize / w

	love.graphics.draw(IMG_POT, self.x - plantSize / 2, self.y - plantSize / 2, 0, scalar, scalar)
end

function Plant:mouseOver (mx, my) 
	return mx > self.rect[1] and my > self.rect[2] and mx < self.rect[1] + self.rect[3] and my < self.rect[2] + self.rect[4]
end