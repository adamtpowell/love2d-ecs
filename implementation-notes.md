# Implementation Ideas

world contains entities and systems, and methods to create them.

systems and entities can also be created seperately, but thats an advanced case.

each type of system has seperate dispatch

for the prototype, there will be no caches. Everything will be calculated every time.

## tickSystems

Called every frame. Iterate over all entities in the world, calling the filter on them. If they do filter. Call process for them.

Pretty simple

## callSystems

the world owns a "calls" table.

when this system is added, add it to the calls table with a key of the method name.

when the system is removed, loop through the corresponding table and remove the entry which contain the system

when adding an entity to the world, add a call method to its metatable. It looks up the method name in the calls table. For each of the methods in that entry, call it if the filter accepts that entitiy. Continue for all of the methods, even if one is called. Multiple matching bindings should all be triggered.

## signalSystems

like a tick system, except they are only called when the appropriate signal is sent through the world.

To do this, keep a table of arrays of systems indexed by their listened signal.
