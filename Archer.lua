require 'Crown'
require 'CannonBall'
Archer = Class{}
function Archer:init(num, x, y, crown, visi)
	self.image = love.graphics. newImage('Archer.png')
	self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.removedx = -1
    self.removedy = -1
    self.crown = crown
    self.spawnTimer = 0
    self.stopped = false
    self.cannonBalls = {}
    self.visi = visi
    if num == 0 then
    	self:sideGen()
    else 
    	self.x = x
	    self.y = y
	    if self.x < 300 then
	    	self.dx = 4
	    else
	    	self.dx = -4
	    end
	    if self.y < 300 then
	    	self.dy = 4
	    else
	    	self.dy =-4
	    end
	    if self.dy < 0 and self.dx < 0 then
	    	self.side = 3
	    elseif self.dy < 0 then
	    	self.side = 4
	    elseif self.dx < 0 then
	    	self.side = 2
	    else
	    	self.side = 1
	    end
    end
end
function Archer:sideGen()
	ver = math.random(0,1)
	hori = math.random(0,1)
	nex = math.random(0,1)
	if vert == 0 and hor ==0 then 
		self.y = 0 - self.height
		self.dy = 4
		if nex == 0 then
			self.x = math.random(0, 150) - self.width/2
			self.dx = 4
			self.side = 1
		else
			self.x = math.random(1130, 1280) - self.width/2
			self.dx = -4
			self.side = 2
		end
	elseif ver == 1 and hori == 1 then
		self.y = 720 
		self.dy = -4
		if nex == 0 then
			self.x = math.random(0, 150) - self.width/2
			self.dx = 4
			self.side = 4
		else 
			self.x = math.random(1130, 1280) - self.width/2
			self.dx = -4
			self.side = 3
		end
	elseif ver == 1 and hori == 0 then
		self.x = 0 - self.width
		self.dx = 4
		if nex == 0 then
			self.y = math.random(0, 150) - self.height/2
			self.dy = 4
			self.side = 1
		else
			self.y = math.random(570, 720) - self.height/2
			self.dy = -4
			self.side = 4
		end
	else 
		self.x = 1280
		self.dx = -4
		if nex == 0 then
			self.y = math.random(0, 150) - self.height/2 
			self.dy = 4
			self.side = 2
		else
			self.y = math.random(570,720) - self.height/2
			self.dy = -4
			self.side = 3
		end
	end
end
function Archer:collide(defender)
	if self.x + self.width < defender.x then
		return false
	elseif self.x > defender.x + defender.width then
		return false
	elseif self.y > defender.y + defender.height then
		return false
	elseif self.y + self.height < defender.y then
		return false
	end
	if not(self.cannonBalls[1] == nil) then
		self.removedx = self.cannonBalls[1].x
		self.removedy = self.cannonBalls[1].y
	end
	return true	
end
function Archer:update(dt)
	self.spawnTimer = self.spawnTimer + dt
	if (self.stopped and self.spawnTimer > 1 and self.visi == 0) then
		if self.side == 1 and self.cannonBalls[1] == nil then
			table.insert(self.cannonBalls, CannonBall((self.x + self.width), self.y + self.height))
		elseif self.side == 2 and self.cannonBalls[1] == nil then
			table.insert(self.cannonBalls, CannonBall((self.x), (self.y + self.height)))
		elseif self.side == 3 and self.cannonBalls[1] == nil then
			table.insert(self.cannonBalls, CannonBall((self.x), (self.y)))
		elseif self.cannonBalls[1] == nil then
			table.insert(self.cannonBalls, CannonBall((self.x + self.width), (self.y)))
		end 
		for k, cannonBall in pairs(self.cannonBalls) do
			cannonBall:update(dt)
			if cannonBall:hit(self.crown) then
				self.crown:softHit()
				table.remove(self.cannonBalls, k)
			end
		end
	end
	if ((self.x < 200) or (self.x + self.width > 1080)) and ((self.y < 200) or (self.y + self.height > 520)) then
		self.x = self.x + self.dx
		self.y = self.y + self.dy
	else 
		self.stopped = true
	end
end	
function Archer:render()
	love.graphics.draw(self.image, self.x, self.y)
	for k, cannonBall in pairs(self.cannonBalls) do
        cannonBall:render()
    end
end