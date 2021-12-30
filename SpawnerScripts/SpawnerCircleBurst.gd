extends SpawnerBase

var count: int = 10
var inner_radius: int = 0

func _ready():
	print("spawner linear loaded")

func _physics_process(delta):
	if ! setup_done:
		var start_angle = randf() * 360
		var spread:float = 360.0 / count
		for i in range(count):
			create_particle(position, start_angle + (spread * i)).modulate = Color(0,1,0)

		setup_done = true

