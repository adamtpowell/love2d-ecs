local tiny = require('tiny')

local world

local sysPlayerMove = tiny.processingSystem()
sysPlayerMove.filter = tiny.requireAll("pos", "bb", "isPlayable")
function sysPlayerMove:process(e, dt)
    e.pos.x = e.pos.x + 1
    if e.pos.x > 300 then
        tiny.removeComponent(e, "pos")
    end
end

local sysDrawBB = tiny.processingSystem()
sysDrawBB.filter = tiny.requireAll("pos", "bb", "debugDrawBB")
function sysDrawBB:process(e, dt)
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("line", e.pos.x, e.pos.y, e.bb.width, e.bb.height)
end

world = tiny.world(sysPlayerMove, sysDrawBB)

function love.load()
    world:addEntity({
        pos = {x=0,y=0},
        bb = {width=100,height=100},
        debugDrawBB = true,
        isPlayable = true,
    })

    world:addEntity({
        pos = {x=100,y=100},
        bb = {width=50,height=50},
        debugDrawBB = true,
    })
end

function love.update(dt)
end

function love.draw()
    world:update(0.001)
end


