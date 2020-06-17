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
require 'states/MenueState'
require 'states/AttackState'
local background = love.graphics.newImage('background.png')
local score = 0
local defender = Defender()
local crown = Crown()
local spawnTimerAtt = 0
local spawnTimerArch = 0
local targetAtt = 2
local targetArch = 4
local attackers = {}
local archers = {}
local cannons = {}
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
    Font = love.graphics.newFont('font.ttf', 46)
    math.randomseed(os.time())
    -- app window title
    love.window.setTitle('Crown Capture')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
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
    if crown.health > 0 then
    	defender:update(dt)
        spawnTimerAtt = spawnTimerAtt + dt
        spawnTimerArch = spawnTimerArch + dt
        if spawnTimerAtt > targetAtt then
            table.insert(attackers, Attacker())
            spawnTimerAtt = 0
            targetAtt = targetAtt * 0.97
        end 
        if spawnTimerArch > targetArch then
            table.insert(archers, Archer(crown))
            spawnTimerArch = 0
            targetArch = targetArch * 0.96
        end
        for k, archer in pairs(archers) do
            archer:update(dt)
            if archer:collide(defender) then
                if not(archer.removedx == -1) then
                    table.insert(cannons, CannonBall(archer.removedx, archer.removedy))
                end
                table.remove(archers, k)
                score = score + 1
            end
            crown = archer.crown
        end
        for k, attacker in pairs(attackers) do
            attacker:update(dt)
            if attacker:collide(defender) then
                table.remove(attackers, k)
                score = score + 1
            elseif attacker:hit(crown) then
                table.remove(attackers, k)
                crown:hit()
            end
        end
        for k, cannon in pairs(cannons) do
            cannon:update(dt)
            if cannon:hit(crown) then
                table.remove(cannons, k)
                crown:softHit()
            end
        end
    end
end
function love.draw()
	push:start()
    love.graphics.draw(background, 0, 0)
	crown:render()
    for k, archer in pairs(archers) do
        archer:render()
    end
    for k, attacker in pairs(attackers) do
        attacker:render()
    end
    defender:render()
    for k, cannon in pairs(cannons) do
        cannon:render()
    end
    love.graphics.setFont(Font)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.printf('Score ' .. tostring(score), 0, 20, VIRTUAL_WIDTH/2, 'center')
	push:finish()
end