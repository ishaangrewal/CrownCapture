DefendState = Class{__includes = BaseState}
function DefendState:init()
	self.score = 0
    self.attackers = {}
    self.archers = {}
	self.defender = Defender(0)
	self.crown = Crown()
	self.spawnTimerAtt = 0
	self.spawnTimerArch = 0
	self.targetAtt = 2
	self.targetArch = 4
	self.cannons = {}
	love.graphics.setFont(Font)
end
function DefendState:update(dt)
    if self.crown.health > 0 then
        self.defender:update(dt)
        self.spawnTimerAtt = self.spawnTimerAtt + dt
        self.spawnTimerArch = self.spawnTimerArch + dt
        if self.spawnTimerAtt > self.targetAtt then
            table.insert(self.attackers, Attacker(0, 0, 0))
            self.spawnTimerAtt = 0
            self.targetAtt = self.targetAtt * 0.97
        end 
        if self.spawnTimerArch > self.targetArch then
            table.insert(self.archers, Archer(0, 0, 0, self.crown, 0))
            self.spawnTimerArch = 0
            self.targetArch = self.targetArch * 0.96
        end
        for k, archer in pairs(self.archers) do
            archer:update(dt)
            if archer:collide(self.defender) then
                if not(archer.removedx == -1) then
                    table.insert(self.cannons, CannonBall(archer.removedx, archer.removedy))
                end
                table.remove(self.archers, k)
                self.score = self.score + 1
            end
            self.crown = archer.crown
        end
        for k, attacker in pairs(self.attackers) do
            attacker:update(dt)
            if attacker:collide(self.defender) then
                table.remove(self.attackers, k)
                self.score = self.score + 1
            elseif attacker:hit(self.crown) then
                table.remove(self.attackers, k)
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
function DefendState:render()
    if self.crown.health > 0 then
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