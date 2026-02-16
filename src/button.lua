-- button size in px
local buttonSize = 64

Button = {
    x = 0,
    y = 0,
    rect = {},
    mouseDown = function () end -- empty func by default
}

function Button:new (x, y, mouseDown)
    local ret = {
        x = x,
        y = y,
        rect = {x - buttonSize / 2, y - buttonSize / 2, buttonSize, buttonSize},
        mouseDown = mouseDown
    }
    self.__index = self
    setmetatable(ret, self)
    return ret
end


function Button:update (dt)
    
end


function Button:draw ()
    local quad = UMouseOver(self.rect) and Assets.quads.seeds.outline or Assets.quads.seeds.noOutline
    love.graphics.draw(Assets.images.sprites.seeds, quad, self.rect[1], self.rect[2], 0, 4, 4)
end