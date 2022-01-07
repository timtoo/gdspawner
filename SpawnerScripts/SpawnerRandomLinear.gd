extends SpawnerBase

var frequency:int = 80

func _ready():
	count = -1 

func _physics_process(delta):
	if (randi() % frequency == 0): 
		# create at a random spot on the screen (relative to spawner position)
		create_particle(random_screen_position() - global_position, randi() % 360)

