Bursty, move-y, wiggly things
-----------------------------

This code was really mostly an investigation of how to do class inheritence with GDScript. 
But then apparently I also needed to dynamically load plugin-like scripts into the scene? 

It all started with `MoveThing.gd` which was meant to be a parent class which could 
cause any script that `extends` it to have certain movement behaviors. 

Then I wanted some different movement behaviors and the `Spawner` was (slowly) born. 
The (possibly) interesting thing about it is that its `generate(name)` funciton dynamically
creates a new node in the tree and dynamically loads the script matching the `name`, which 
contains the specific animation behavior. 

WARNING: there is certainly a lot wrong with this code, as fumbled a lot trying to get it to work,
and it is a mess. It's basically the first way I could figure out, probably not the best way. For example, the spawners don't have a way to set defaults whent they are created. But maybe it will provide some ideas or clues to someone. Inability to override class variable defaults is still a mystery. GDScript is a bit mysterious in how it glues objects together. I would recommend C#, if possible.

Nevertheless, enjoy.

https://timtoo.github.io/gdspawner/

(p.s. press `c` for a big mess)

## Code breakdown

- `Root.gd` - controls the frequency of the different types of spawners generating
- `Spawner.gd` - merely provides the `generate()` function
- `SpawnerBase.gd` - provides for all spawners the `create_particle()` function, and keeps track of all particles created in an array (I never used this, but it could be useful)
- `SpawnerNAME.gd` - the varoius spawners. Each provides a `_physics_process()` to generate particles, and does whatever state management necessary for their patterns
- `MoveThing.gd` - just keeps an object moving, with some zig-zaggy options
- `particle.gd` - does nothing (except set screen edge buffer width)! All the code is in `MoveThing.gd`.

Source code: https://github.com/timtoo/gdspawner/
