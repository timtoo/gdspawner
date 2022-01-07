extends SpawnerBase

var inner_radius: int = 0
var color: Color = Color(0,1,0)

func _init():
	count = 10

func _physics_process(delta):
	if ! setup_done:
		var start_angle = randf() * 360
		var spread:float = 360.0 / count
		for i in range(count):
			create_particle(position, start_angle + (spread * i)).modulate = color

		setup_done = true

