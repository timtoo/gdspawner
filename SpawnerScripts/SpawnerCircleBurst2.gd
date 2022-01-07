extends SpawnerBase

var levels: int = randi() % 7 + 3
var inner_radius: int = 0

var level: int = 0
var wait: bool = false

var color: Color = Color(0.1,0.7,0.1)
var timer: Timer = Timer.new()

func _init():
	count = 10

func _ready():
	timer.wait_time = 0.1
	timer.connect("timeout", self, "timer_timeout")
	add_child(timer)
	color = random_color()

func timer_timeout():
	wait = false

func _physics_process(delta):
	if wait == false && level < levels:
		var start_angle = randf() * 360
		var spread:float = 360.0 / count
		var cm:float = 1.0 - (float(level) / levels / 2.0)
		print("cm ", cm )
		for i in range(count):
			create_particle(position, start_angle + (spread * i)).modulate = Color(color.r*cm, color.g*cm, color.b*cm)

		wait = true
		level += 1
		timer.start()
