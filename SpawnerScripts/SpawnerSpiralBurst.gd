extends SpawnerBase

var count: int = randi() % 100 + 20
var spread: int = (randi() % 5 + 1) * 5
var inner_radius: int = 0
var start_angle = randf() * 360
var angle = start_angle

var current: int = 0
var wait: bool = false

var timer: Timer = Timer.new()

func _ready():
	timer.wait_time = 0.05
	timer.connect("timeout", self, "timer_timeout")
	add_child(timer)

func timer_timeout():
	wait = false

func _physics_process(delta):
	if wait == false && current < count:
		create_particle(position, angle).modulate = Color(0.4,0.3,0.8 - (current/120))
		wait = true
		angle += spread
		current += 1
		timer.start()
