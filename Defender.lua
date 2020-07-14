Defender = Class{}
function Defender:init(num)
	self.image = love.graphics. newImage('Defender.png')
	self.width = self.image:getWidth()
    self.height = self.image:getHeight() 
    self.x = 1280 / 2 - (self.width / 2) 
    self.y = 720 / 2 - (self.height / 2) - 250
    self.dx = 0
    self.dy = 0
    self.num = num
    if num == 1 then
    	self.attackers = {} 
    	self.archers = {} 
    end
end
function Defender:update(dt)
	if self.num == 0 then
		xaxis , yaxis = love.mouse.getPosition()
		if xaxis > 0 + self.width/2 and xaxis < 1280 - self.width/2 then 
			self.x = xaxis - self.width / 2
		end
		if yaxis > 0 + self.height/2 and yaxis < 720 - self.height/2 then
			self.y = yaxis - self.height /2
		end
	else
		self:nearest()
		self.x = self.x + self.dx
		self.y = self.y + self.dy
	end
	if (self.num == 1) then
		for l, archer in pairs(self.archers) do
			archer:update(dt)
		end
		for l, attacker in pairs(self.attackers) do
			attacker:update(dt)
		end
	end
end
function Defender:nearest()
	if not(self.archers[1] == nil) then
		self.dy = (self.archers[1].y - self.y - self.height/2)/50
	    self.dx = (self.archers[1].x - self.x - self.width/2)/50 
	elseif not(self.attackers[1] == nil) then
		self.dy = (self.attackers[1].y - self.y - self.height/2)/30
		self.dx = (self.attackers[1].x - self.x - self.width/2)/30
	else  
	    self.dx = 0
		self.dy = 0
	end
end
function Defender:addArch(Archer)
	table.insert(self.archers, Archer)
end
function Defender:addAtt(Attacker)
	table.insert(self.attackers, Attacker)
end
function Defender:remArch(num)
	table.remove(self.archers, num)
end
function Defender:remAtt(num)
	table.remove(self.attackers, num)
end
function Defender:render()
    love.graphics.draw(self.image, self.x, self.y)
end
