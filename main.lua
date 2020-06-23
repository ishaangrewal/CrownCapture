push = require 'push'
Class = require 'class'
require 'Defender'
require 'Crown'
require 'Attacker'
require 'Archer'
require 'CannonBall'
require 'StateMachine'
require 'states/BaseState'
require 'states/DefendState'
require 'states/MenuState'
require 'states/AttackState'
require 'states/InstructionsState'
local background = love.graphics.newImage('background.png')

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
    Font = love.graphics.newFont('font.ttf', 48)
    math.randomseed(os.time())
    -- app window title
    love.window.setTitle('Crown Capture')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
    gStateMachine = StateMachine {
        ['menu'] = function() return MenuState() end,
        ['defend'] = function() return DefendState() end,
        ['instructions'] = function() return InstructionsState() end,
        ['attack'] = function() return AttackState() end
    }
    gStateMachine:change('menu')
    push:resize(WINDOW_WIDTH, WINDOW_HEIGHT)
end
function love.keypressed(key)
    -- keys can be accessed by string name
    if key == 'escape' then
        -- function LÖVE gives us to terminate application
        love.event.quit()
    end
end

function love.resize(w, h)
	push:resize(w, h)
end


function love.update(dt)
    gStateMachine:update(dt)
end
function love.draw()
	push:start()
    love.graphics.draw(background, 0, 0)
	gStateMachine:render()
	push:finish()
end