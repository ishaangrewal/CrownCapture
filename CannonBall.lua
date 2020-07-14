CannonBall = Class{}
function CannonBall:init(x, y)
	self.x = x
	self.y = y
	self.dy = (360 - self.y)/100
    self.dx = (640 - self.x)/100
end
function CannonBall:hit(crown)
	if self.x + 10 < crown.x then
		return false
	elseif self.x > crown.x + crown.width then
		return false
	elseif self.y > crown.y + crown.height then
		return false
	elseif self.y + 10 < crown.y then
		return false
	end
	return true
end
function CannonBall:update(dt)
	self.x = self.x + self.dx
	self.y = self.y + self.dy
end
function CannonBall:render()
	love.graphics.rectangle('fill', self.x, self.y, 10, 10)
end