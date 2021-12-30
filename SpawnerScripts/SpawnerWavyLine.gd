extends SpawnerBase

var length: int = randi() % 15 + 10

var timer: Timer = Timer.new()
var count: int = length
var wait: bool = false

var direction: int = randi() % 360
var start_position = global_position
var angle_range: int = randi() % 80 + 10
var angle_freq: float = randf()/2 + 0.01 

func _ready():
	timer.wait_time = 0.1
	timer.connect("timeout", self, "timer_timeout")
	add_child(timer)
	timer.start()
	start_position = random_screen_position() - global_position
	print("Wavy ", length, " ", angle_freq)

func timer_timeout():
	wait = false
	if ! (count > 0):
		timer.stop()
	else:
		timer.start()

func _physics_process(delta):
	if wait == false && count > 0: 
		# create at a random spot on the screen (relateive to spawner position)
		create_particle(start_position, direction).set_angle_oscillator(angle_range, angle_freq).modulate = Color(0.9,0.3,0.2)
		count -= 1
		wait = true

