extends SpawnerBase


func _ready():
	print("spawner linear loaded")

func _physics_process(delta):
	if (randi() % 80 == 0): 
		# create at a random spot on the screen (relative to spawner position)
		create_particle(random_screen_position() - global_position, randi() % 360)

