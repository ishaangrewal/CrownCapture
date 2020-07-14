Crown = Class{}
function Crown:init()
	self.health = 100
	self.image = love.graphics. newImage('Crown.png')
	self.width = self.image:getWidth()
    self.height = self.image:getHeight() 
    self.x = 1280 / 2 - (self.width / 2) 
    self.y = 720 / 2 - (self.height / 2)
end
function Crown:hit()
	self.health = self.health - 10
end
function Crown:softHit()
	self.health = self.health - 5
end
function Crown:render()
	love.graphics.draw(self.image, self.x, self.y)
	if self.health > 0 then
		love.graphics.rectangle('fill', self.x, self. y - 25, 75*self.health/100, 10)
	end
end