InstructionsState = Class{__includes = BaseState}
function InstructionsState:init()
	love.graphics.setFont(Font)
end
function InstructionsState:update(dt)
	if (love.keyboard.isDown('return')) then
		gStateMachine:change('menu')
	end
	
end
function InstructionsState:render()
	love.graphics.printf('For Defending: Protect the crown from attackers by catching them with your mouse (the Defender) BEWARE OF SHOOTERS!', 100, 100, 1100, 'center')
	love.graphics.printf('Press Enter to go back to the menu', 100, 600, VIRTUAL_WIDTH - 100, 'center')
	love.graphics.printf('For Attacking: Click on Attacker campsites to spawn them and destroy the crown as fast as you can!', 100, 375, 1100, 'center')

end
