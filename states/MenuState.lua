local font = love.graphics.newFont('font.ttf', 32)
local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
MenuState = Class{__includes = BaseState}
function MenuState:init()
	self.image1 = love.graphics.newImage('Defender.png')
	self.image2 = love.graphics.newImage('Attacker.png')
	love.graphics.setFont(Font)
	


end
function MenuState:update(dt)
	if love.mouse.isDown(1) then
		x, y = love.mouse.getPosition()
		if (x > 490 and x < 590 and y > 225 and y < 325) then
			gStateMachine:change('defend')
		elseif (x > 690 and x < 790 and y > 225 and y < 325) then
			gStateMachine:change('attack')
		elseif (x > 475 and x < 795 and y > 600 and y < 650) then
			gStateMachine:change('instructions')
		end
	end
end
function MenuState:render()
	love.graphics.printf('Click an Icon to choose game mode', 0, 150, 1280, 'center')
	love.graphics.rectangle('fill', 490, 225, 100, 110)
	love.graphics.draw(self.image1, 495, 235)
	love.graphics.printf('Defend', 300, 350, 500, 'center')
	love.graphics.rectangle('fill', 690, 225, 100, 110)
	love.graphics.draw(self.image2, 700, 225)
	love.graphics.printf('Attack', 475, 350, 550, 'center')
	love.graphics.rectangle('fill', 475, 600, 320, 50, 25, 25)
	love.graphics.setColor(0,0,0,255)
	love.graphics.printf('Instructions', 0, 600, VIRTUAL_WIDTH, 'center')
end