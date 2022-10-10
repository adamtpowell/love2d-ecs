local tiny = require('tiny')

local world = tiny.world()

local sysDrawBB = world:addSystem(tiny.processingSystem())
sysDrawBB.filter = tiny.requireAll("pos", "bb", "debugDrawBB")
function sysDrawBB:process(e, dt)
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("line", e.pos.x, e.pos.y, e.bb.width, e.bb.height)
end

function love.load()
    world:refresh()

    world:addEntity({
        pos = {x = 0, y = 0},
        bb = {width = 100, height = 100},
        debugDrawBB = true,
    })

    love.window.setVSync(0)
end

function love.update(dt)
end

function love.draw()
    local dt = love.timer.getDelta()
    world:update(dt)
end


