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
	drawPot = true,
	state = PlantState.Empty,
	rect = {},
	dayCount = 0
}


-- creates a new plant object at position 'x' and 'y'
function Plant:new (x, y, drawPot)
	local ret = {
		x = x,
		y = y,
		drawPot = drawPot,
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
	if self.state == PlantState.Empty then
		return
	end

	self.dayCount = self.dayCount + 1


	-- https://www.desmos.com/calculator/luuwsie9qp
	if self.state == PlantState.Seedling then
		local maxDays = 20
		local start = 0.3
		local chance = ((self.dayCount / maxDays) ^ 2 - 1) * (1 - start) + 1
		if math.random() < chance then
			self.state = PlantState.Grown
			self.dayCount = 0
		end
	elseif self.state == PlantState.Grown then
		local maxDays = 5
		local start = 0.1
		local chance = ((self.dayCount / maxDays) ^ 2 - 1) * (1 - start) + 1
		if math.random() < chance then
			self.state = PlantState.Fruit
			self.dayCount = 0
		end
	end
end

function Plant:update (dt)
	
end

function Plant:draw ()

	-- draw bg if planting to seed
	if UMouseOver(self.rect) and ((Cursor == CursorState.Seed and self.state == PlantState.Empty) or (Cursor == CursorState.Scissors and self.state == PlantState.Fruit)) then
		love.graphics.setColor(203/255, 219/255, 252/255)
		love.graphics.rectangle("fill", self.rect[1], self.rect[2], self.rect[3], self.rect[4])
	end

	-- set clear color to white, so sprite wont be altered
	love.graphics.setColor(1.0, 1.0, 1.0)
	
	local w, _ = Assets.images.pot:getDimensions()
	local scalar = plantSize / w

	local plantedIn = self.drawPot and Assets.images.pot or Assets.images.soil
	love.graphics.draw(plantedIn, self.rect[1], self.rect[2], 0, scalar, scalar)

	-- draw plant
	if self.state == PlantState.Empty then
		return
	end

	love.graphics.draw(Assets.images.sprites.plant, Assets.quads.plant[self.state], self.rect[1], self.rect[2], 0, scalar, scalar)
end

function Plant:mouseDown ()
	if Cursor == CursorState.Seed and self.state == PlantState.Empty then
		-- plant if cursor is seed
		self.state = PlantState.Seedling
		SetCursorState(CursorState.Arrow)
	elseif Cursor == CursorState.Scissors and self.state == PlantState.Fruit then
		self.state = PlantState.Grown
		Fruits = Fruits + 1
		SetCursorState(CursorState.Arrow)
	end
end