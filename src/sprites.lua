local assets = {}

function assets.load()
	assets.images = {
		pot = love.graphics.newImage("res/pot.png"),

		sprites = {
			seeds = love.graphics.newImage("res/seeds.png")
		}
	}

	assets.quads = {
		seeds = {
			noOutline = love.graphics.newQuad(0, 0, 16, 16, assets.images.sprites.seeds),
			outline = love.graphics.newQuad(16, 0, 16, 16, assets.images.sprites.seeds)
		}
	}
end

return assets