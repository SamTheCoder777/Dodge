Player = Class{}

function Player:init(x,y,width,height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dx = 0
end

function Player:update(dt)
    if self.dx < 0 then
        self.x = math.max(0, self.x +self.dx*dt)
    
    else
        self.x = math.min(love.graphics.getWidth()+1180-self.x, self.x + self.dx * dt)
    end
end

function Player:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end