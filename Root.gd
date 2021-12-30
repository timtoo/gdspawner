extends Node2D

var screen_size: Vector2
var spawner = preload("res://Spawner.tscn")

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	randomize()

	var spawn = spawner.instance()
	add_child(spawn)
	spawn.generate('RandomLinear')
func random_screen_position() -> Vector2:
	return Vector2(randi() % int(screen_size.x), randi() % int(screen_size.y))

# note: spawn nodes are not cleaned up, so is a memory leak situation
func _process(delta):
	if randi() % 100 == 0:
		var spawn = spawner.instance()
		add_child(spawn)
		spawn.generate("CircleBurst", random_screen_position()).count = (randi() % 46) + 5

	if randi() % 150 == 0:
		var spawn = spawner.instance()
		add_child(spawn)
		spawn.generate("CircleBurst2", random_screen_position()).count = (randi() % 46) + 5

	if randi() % 200 == 0:
		var spawn = spawner.instance()
		add_child(spawn)
		spawn.generate("SpiralBurst", random_screen_position())
	
	if randi() % 200 == 0:
		var spawn = spawner.instance()
		add_child(spawn)
		spawn.generate("WavyLine", random_screen_position())
		
	

