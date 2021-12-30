# A Kinematic2D object that just keeps moving in the direction it is facing.
# Optionally oscillation on a timer.


# and deletes itself when it's far enough off the screen.

extends KinematicBody2D
class_name MoveThing

var speed: float = 10000.0

var screen_size: Vector2
var minBound: Vector2;
var maxBound: Vector2;
var buffer: int = 0    # how far off screen until queue_free

var oscillatorState: int = 0
var oscillatorRange: float = 0
var oscillatorFrequency: float = 1.0
var oscillatorAngleTimer: Timer = Timer.new()

func _ready():
	# so we can automatically kill ourselves when out of bounds
	screen_size = get_viewport().get_visible_rect().size
	set_buffer(buffer)

func test():
	pass

func set_angle_oscillator(degree_range: int, frequency: float, initial_state:int=1):
	if oscillatorState == 0:
		add_child(oscillatorAngleTimer)
	oscillatorAngleTimer.connect("timeout", self, "oscillatorAngleTimer_timeout")
	oscillatorFrequency = frequency
	oscillatorAngleTimer.wait_time = frequency
	oscillatorRange = deg2rad(degree_range) / 2.0
	oscillatorState = initial_state
	oscillatorAngleTimer.start()
	return self

func oscillatorAngleTimer_timeout():
	oscillatorState = oscillatorState * -1

func set_buffer(size: int):
	buffer = size
	minBound = Vector2(-buffer, -buffer)
	maxBound = Vector2(screen_size.x + buffer, screen_size.y + buffer)	

func _physics_process(delta: float):
	move_and_slide(Vector2(speed * delta,0).rotated(rotation + (oscillatorRange * oscillatorState)))

func _process(_delta: float):
	if (global_position.x < minBound.x || global_position.x -1 > maxBound.x || 
			global_position.y < minBound.y || global_position.y -1 > maxBound.y):
		#print("bye-bye from ", get_instance_id())
		queue_free()
