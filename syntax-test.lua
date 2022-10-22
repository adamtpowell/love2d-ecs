local world, ecs

-- TODO: Come up with a satisfiying way to do state machines

-- create a world with a state machine object. it calls any states within it that are active. state machines contain a world, states live within it and call things.12qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq

-- individual states are entities. They have a method which sets them as active by name,

-- TODO: How do nested state machines work?
--      A: states are just held within the world. state machines are created with a factory funciton for the state machine system.
--      the world is only updated

-- TODO: How do callTriggers work with multiple different worlds?
--      A: Since entities are within a specific world and only one world, its a nonissue. Information hiding isn't needed.
--      because of this, its fine that calling within another worlds update method will call the method bound elsewhere.

world:entity{
}

local sysMoveObjects = world:tickSystem()
    :filter(ecs.requireAll("dir", "vel", "pos")) -- Could there be operators to combine these?
    :process(function(e)
        -- MOVE ACCORDING TO ENTITIES COMPONENTS
    end)

-- This is a way of dynamically fizzling all fizzalabe things
-- Anything that is fizzleable will now have its fizzle method called when the fizzle signal is sent to the world.
-- OR: Everything with fizzleable component will have its fizzle method called when it hears the signal fizzle.
local sysTriggerFizzle = world:eventSystem("fizzle")
    :filter(ecs.requireAll("fizzleable"))
    :process(function(e)
        e:fizzle()
    end)

-- Binds a method to all bullets that handles fizzling
local sysFizzleBullets = world:callSystem("fizzle")
    :filter(ecs.requireAll("fizzleable", "bullet"))
    :process(function(bullet)
        bullet:remove()
    end)

-- Binds a method to all lasers that handles fizzling
local sysFizzleBullets = world:callSystem("fizzle")
    :filter(ecs.requireAll("fizzleable", "laser"))
    :process(function(laser)
        laser:remove()
    end)
