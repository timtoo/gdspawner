extends Node2D

var spawner = preload("res://Spawner.tscn")

var collision_enabled = false  # this is a mess! but for fun...? 

# [ odds_of_spawning, min_count, max_count ]
var spawners: Dictionary = {
	"CircleBurst": [100, 5, 50],
	"CircleBurst2": [150, 5, 50],
	"SpiralBurst": [200, 20, 120],
	"WavyLine": [200, 10, 25],
	"RandomLinear": [0, 0, 0]
}

func _ready():
	if OS.get_name() == 'HTML5':
		$WorldEnvironment.queue_free()

	randomize()

	var spawn = spawner.instance()
	add_child(spawn)
	spawn.generate('RandomLinear')

func random_screen_position() -> Vector2:
	var screen_size = get_viewport().get_visible_rect().size
	return Vector2(randi() % int(screen_size.x), randi() % int(screen_size.y))

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_C:
			collision_enabled = ! collision_enabled
			print("Collision ?! ", collision_enabled)	

# note: spawn nodes are not cleaned up, so is a memory leak situation
func _process(delta):

	for i in spawners:
		if (spawners[i][0] != 0) && (randi() % spawners[i][0] == 0):
			var spawn = spawner.instance()
			var rndrange = spawners[i][2] - spawners[i][1] + 1
			var spawned = spawn.generate(i, random_screen_position())
			spawned.set_count((randi() % rndrange)+spawners[i][1])
			add_child(spawn)

	

