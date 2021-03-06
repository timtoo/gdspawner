extends SpawnerBase

var length: int = randi() % 15 + 10

var timer: Timer = Timer.new()
var wait: bool = false

var direction: int = randi() % 360
var start_position = global_position
var angle_range: int = randi() % 110 + 10
var angle_freq: float = randf()/2 + 0.01 
var wait_time: float = (randi() % 4 + 2) / 20.0

var color: Color = Color(0.9,0.3,0.2)

func _ready():
	count = length
	timer.wait_time = wait_time
	timer.connect("timeout", self, "timer_timeout")
	add_child(timer)
	timer.start()
	start_position = random_screen_position() - global_position
	color = random_color()
	print("Wavy ", length, " ", angle_freq)

func set_count(i: int) -> void:
	length = i
	count = i

func timer_timeout():
	wait = false
	if ! (length > 0):
		timer.stop()
	else:
		timer.start()

func _physics_process(delta):
	if wait == false && length > 0: 
		# create at a random spot on the screen (relateive to spawner position)
		var cm = 1.0 - float(length % 2)/4.0
		create_particle(start_position, direction).set_angle_oscillator(angle_range, angle_freq).modulate = Color(color.r*cm, color.g*cm, color.b*cm)
		length -= 1
		wait = true

