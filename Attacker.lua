Attacker = Class{}
local SPEED = 100 
function Attacker:init(num, x, y, visi)
	self.image = love.graphics. newImage('Attacker.png')
	self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.visi = visi
    if (num == 0) then
    	self:randomGen()
    else
    	self.x = x
    	self.y = y
    end
    self.dy = (360 - self.y - self.height/2)/SPEED
    self.dx = (640 - self.x - self.width/2)/SPEED
end
function Attacker:collide(defender)
	if self.x + self.width < defender.x then
		return false
	elseif self.x > defender.x + defender.width then
		return false
	elseif self.y > defender.y + defender.height then
		return false
	elseif self.y + self.height < defender.y then
		return false
	end
	return true	
end
function Attacker:hit(crown)
	if self.x + self.width < crown.x then
		return false
	elseif self.x > crown.x + crown.width then
		return false
	elseif self.y > crown.y + crown.height then
		return false
	elseif self.y + self.height < crown.y then
		return false
	end
	return true
end
function Attacker:randomGen()
	vert = math.random(0,1)
	hor = math.random(0,1)
	if vert == 0 and hor ==0 then 
		self.y = 0
		self.x = math.random(150, 1130)
	elseif vert == 1 and hor == 1 then
		self.y = 720 + self.height
		self.x = math.random(150, 1130)
	elseif vert == 1 and hor == 0 then
		self.x = 0
		self.y = math.random (150, 570)
	else 
		self.x = 1280 + self.width
		self.y = math.random(150, 570)
	end
end
function Attacker:update(dt)
	self.x = self.x + self.dx
	self.y = self.y + self.dy
end
function Attacker:render()
		love.graphics.draw(self.image, self.x, self.y)
end
