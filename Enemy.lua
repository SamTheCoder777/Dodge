Enemy = Class{}
function Enemy:init(x,y,width,height,dy)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = dy
end

function Enemy:update(dt)
    self.y = self.y + self.dy*dt
    if self.y > 1280 - 500 then
        self.x = math.random(1,1120)
        self.y = -150
        
    end
end

function Enemy:collides(player)
    if self.x > player.x + player.width or player.x > self.x + self.width then
        return false
    end
    if self.y > player.y + player.height or player.y > self.y + self.height then
        return false
    end
    self.y = 10000
    return true
end

function Enemy:render()
    love.graphics.setColor(255,0,0,255)
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end