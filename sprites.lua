function loadSprites ()
	IMG_POT = love.graphics.newImage("res/pot.png")
	

	-- seeds
	SPRITE_SEED = love.graphics.newImage("res/seeds.png")
	local w, h = SPRITE_SEED:getDimensions()
	QUAD_SEED = {
		NoOutline = love.graphics.newQuad(0, 0, 16, 16, SPRITE_SEED),
		Outline = love.graphics.newQuad(16, 0, 16, 16, SPRITE_SEED)
	}
end

function drawSprite (sprite, quad, x, y)
	love.graphics.draw(sprite, quad, x, y)
end