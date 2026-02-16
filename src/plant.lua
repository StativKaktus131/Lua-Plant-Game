require("src.sprites")

-- size in pixels
local plantSize = 128


-- Plant State will dictate sprite position
PlantState = {
	Empty = 0,
	Seedling = 1,
	Grown = 2,
	Fruit = 3
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
		-- state = math.random(3),
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

	-- draw bg if planting to seed
	if UMouseOver(self.rect) and Cursor == CursorState.Seed then
		love.graphics.setColor(203/255, 219/255, 252/255)
		love.graphics.rectangle("fill", self.rect[1], self.rect[2], self.rect[3], self.rect[4])
	end

	-- set clear color to white, so sprite wont be altered
	love.graphics.setColor(1.0, 1.0, 1.0)
	
	local w, _ = Assets.images.pot:getDimensions()
	local scalar = plantSize / w

	love.graphics.draw(Assets.images.pot, self.rect[1], self.rect[2], 0, scalar, scalar)

	-- draw plant
	if self.state == PlantState.Empty then
		return
	end

	love.graphics.draw(Assets.images.sprites.plant, Assets.quads.plant[self.state], self.rect[1], self.rect[2], 0, scalar, scalar)
end

function Plant:mouseDown ()
	if Cursor == CursorState.Seed then
		-- plant if cursor is seed
		self.state = PlantState.Seedling
		setCursorState(CursorState.Arrow)
	end
end