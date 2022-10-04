local tiny = require('tiny')

local changeList = {}
local world

local function removeComponent(e, name)
    e[name] = nil
    tiny.addEntity(world, e)
end

local sysPlayerMove = tiny.processingSystem()
sysPlayerMove.filter = tiny.requireAll("pos", "bb", "isPlayable")
function sysPlayerMove:process(e, dt)
    print("move")
    e.pos.x = e.pos.x + 1
    if e.pos.x > 300 then
        removeComponent(e, "pos")
    end
end

local sysDrawBB = tiny.processingSystem()
sysDrawBB.filter = tiny.requireAll("pos", "bb", "debugDrawBB")
function sysDrawBB:process(e, dt)
    print("draw")
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("line", e.pos.x, e.pos.y, e.bb.width, e.bb.height)
end

world = tiny.world(sysPlayerMove, sysDrawBB)

function love.load()
    tiny.addEntity(world, {
        pos = {x=0,y=0},
        bb = {width=100,height=100},
        debugDrawBB = true,
        isPlayable = true,
    })

    tiny.addEntity(world, {
        pos = {x=100,y=100},
        bb = {width=50,height=50},
        debugDrawBB = true,
    })
end

function love.update(dt)
end

function love.draw()
    print(changeList)
    for i = #changeList, 1, -1 do
        tiny.addEntity(world, changeList[i])
        table.remove(changeList, i)
    end

    world:update(0.001)
end


