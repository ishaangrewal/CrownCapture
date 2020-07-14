local background = love.graphics.newImage('background5.png')
AttackState = Class{__includes = BaseState}
function AttackState:init()
	self.score = 100
	self.attackers = {}
	self.archers = {}
	self.crown = Crown()
	self.defender = Defender(1)
	self.cannons = {}
	self.test = 0
	love.graphics.setFont(Font)
end
function spawn(xcord, ycord)
	if (xcord < 1130 and xcord > 150 and ((ycord < 50) or (ycord > 670))) then
		return 'attacker'
	elseif (ycord < 570 and ycord > 150 and (xcord < 50 or xcord > 1130)) then
		return 'attacker'
	elseif (ycord < 50 or ycord > 670 or xcord < 50 or xcord > 1230) then
		return 'archer'
	else 
		return 'null'
	end
end

function AttackState:update(dt)
	if self.crown.health > 0 then
		self.defender:update(dt)
		if love.mouse.isDown(1) then
			if self.test == 0 then
				x, y = love.mouse.getPosition()
				if (spawn(x, y) == 'attacker') then
					table.insert(self.attackers, Attacker(1, x, y, 0))
					self.defender:addAtt(Attacker(1, x, y, 1))
				elseif(spawn(x, y) == 'archer') then
					table.insert(self.archers, Archer(1, x, y, self.crown, 0))
					self.defender:addArch(Archer(1, x, y, self.crown, 1))
				end
				self.test = self.test + 1
			end
		elseif self.test > 0 then
			self.test = 0
		end
		for k, archer in pairs(self.archers) do
	        archer:update(dt)
	        if archer:collide(self.defender) then
	            if not(archer.removedx == -1) then
	                table.insert(self.cannons, CannonBall(archer.removedx, archer.removedy))
	            end
	            table.remove(self.archers, k)
	            self.defender:remArch(k)
	            self.score = self.score - 1
	        end
	        self.crown = archer.crown
	    end
	    for k, attacker in pairs(self.attackers) do
	        attacker:update(dt)
	        if attacker:collide(self.defender) then
	            table.remove(self.attackers, k)
	            self.defender:remAtt(k)
	            self.score = self.score - 1
	        elseif attacker:hit(self.crown) then
	            table.remove(self.attackers, k)
	            self.defender:remAtt(k)
	            self.crown:hit()
	        end
	    end
	    for k, cannon in pairs(self.cannons) do
	        cannon:update(dt)
	        if cannon:hit(self.crown) then
	            table.remove(self.cannons, k)
	            self.crown:softHit()
	        end
	    end
	elseif love.keyboard.isDown('return') then
	    gStateMachine:change('menu')
	end
end
function AttackState:render()
	if self.crown.health > 0 then 
		love.graphics.draw(background, 0, 0)
		self.crown:render()
		for k, archer in pairs(self.archers) do
	        archer:render()
	    end
	    for k, attacker in pairs(self.attackers) do
	        attacker:render()
	    end
	    self.defender:render()
	    for k, cannon in pairs(self.cannons) do
	        cannon:render()
	    end
		love.graphics.setColor(0, 1, 0, 1)
		love.graphics.printf('Score ' .. tostring(self.score), 0, 50, VIRTUAL_WIDTH/2, 'center')
	else 
        love.graphics.printf('GAME OVER', 0, 300, 1280, 'center')
        love.graphics.printf('Your score:' .. tostring(self.score), 0, 350, 1280, 'center')
        love.graphics.printf('Press Enter to go back to menu', 0, 400, 1280, 'center')
    end
end