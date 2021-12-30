extends SpawnerBase

var count: int = 10
var levels: int = randi() % 7 + 3
var inner_radius: int = 0

var level: int = 0
var wait: bool = false

var timer: Timer = Timer.new()

func _ready():
	timer.wait_time = 0.1
	timer.connect("timeout", self, "timer_timeout")
	add_child(timer)

func timer_timeout():
	print("TIMEOUT.............................")
	wait = false

func _physics_process(delta):
	if wait == false && level < levels:
		var start_angle = randf() * 360
		var spread:float = 360.0 / count
		for i in range(count):
			create_particle(position, start_angle + (spread * i)).modulate = Color(0.1,0.7 - level/50.0,0.1)

		wait = true
		level += 1
		timer.start()
