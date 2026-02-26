-- button size in px
local buttonSize = 64

ButtonType = {
    Seeds = 0,
    Scissors = 1
}

Button = {
    x = 0,
    y = 0,
    buttonType = ButtonType.Seeds,
    rect = {},
    mouseDown = function () end -- empty func by default
}

function Button:new (anchor, x, y, buttonType, mouseDown)
    local tempX = 0.5 * (anchor.x + 1) * Width - 0.5 * (anchor.x + 1) * buttonSize + x
    local tempY = 0.5 * (anchor.y + 1) * Height - 0.5 * (anchor.y + 1) * buttonSize + y

    local ret = {
        x = tempX,
        y = tempY,
        buttonType = buttonType,
        rect = {tempX, tempY, buttonSize, buttonSize},
        mouseDown = mouseDown
    }
    self.__index = self
    setmetatable(ret, self)
    return ret
end


function Button:update (dt)
    
end


function Button:draw ()
    local quad = UMouseOver(self.rect) and Assets.quads.tools[self.buttonType * 2 + 2] or Assets.quads.tools[self.buttonType * 2 + 1]
    love.graphics.draw(Assets.images.sprites.tools, quad, self.rect[1], self.rect[2], 0, 4, 4)
end