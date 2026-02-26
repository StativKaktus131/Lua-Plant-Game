local assets = {}

function assets.load()
	assets.images = {
		pot = love.graphics.newImage("res/pot.png"),
		soil = love.graphics.newImage("res/soil.png"),

		backgrounds = {
			layout = love.graphics.newImage("res/backgrounds/layout.png")
		},

		sprites = {
			tools = love.graphics.newImage("res/tools.png"),
			plant = love.graphics.newImage("res/plant.png")
		}
	}

	assets.quads = {
		tools = {
			-- seeds
			love.graphics.newQuad(0, 0, 16, 16, assets.images.sprites.tools),
			-- seeds outlined
			love.graphics.newQuad(16, 0, 16, 16, assets.images.sprites.tools),
			-- scissors
			love.graphics.newQuad(0, 16, 16, 16, assets.images.sprites.tools), 
			-- scissors outlined
			love.graphics.newQuad(16, 16, 16, 16, assets.images.sprites.tools), 
		},
		plant = {
			-- seedling
			love.graphics.newQuad(0, 0, 32, 32, assets.images.sprites.plant),
			-- grown
			love.graphics.newQuad(32, 0, 32, 32, assets.images.sprites.plant),
			-- fruit
			love.graphics.newQuad(64, 0, 32, 32, assets.images.sprites.plant),
		},
	}

	assets.cursors = {
		-- arrow
		{
			img = love.graphics.newImage("res/cursors/cur_arrow.png"),
			hotx = 4,
			hoty = 2
		},
		-- hand
		{
			img = love.graphics.newImage("res/cursors/cur_hand.png"),
			hotx = 5,
			hoty = 4
		},
		-- seed
		{
			img = love.graphics.newImage("res/cursors/cur_seed.png"),
			hotx = 0,
			hoty = 15
		},
		-- scissors
		{
			img = love.graphics.newImage("res/cursors/cur_scissors.png"),
			hotx = 2,
			hoty = 13
		},

		empty = love.mouse.newCursor("res/cursors/cur_empty.png", 0, 0)
	}
end

return assets