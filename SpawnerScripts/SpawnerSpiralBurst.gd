extends SpawnerBase

var spread: int = (randi() % 5 + 1) * 5
var inner_radius: int = 0
var start_angle = randf() * 360
var angle = start_angle
var color: Color = Color(0.4,0.3,0.8)

var current: int = 0
var wait: bool = false

var timer: Timer = Timer.new()

func _init():
	count = randi() % 100 + 20

func _ready():
	timer.wait_time = randf() / 10 + 0.01
	print("timer wait ", timer.wait_time)
	timer.connect("timeout", self, "timer_timeout")
	add_child(timer)
	color = random_color()

func timer_timeout():
	wait = false

func _physics_process(delta):
	if wait == false && current < count:
		var cm:float = 1.0 - (float(current) / count / 2.0)
		create_particle(position, angle).modulate = Color(color.r*cm, color.g*cm, color.b*cm)
		wait = true
		angle += spread
		current += 1
		timer.start()
