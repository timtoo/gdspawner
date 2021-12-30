# A Kinematic2D object that just keeps moving in the direction it is facing
# and deletes itself when it's far enough off the screen.

extends KinematicBody2D
class_name MoveThing

var speed: float = 10000.0

var screen_size: Vector2
var minBound: Vector2;
var maxBound: Vector2;
var buffer: int = 0    # how far off screen until queue_free

func _ready():
	# so we can automatically kill ourselves when out of bounds
	screen_size = get_viewport().get_visible_rect().size
	set_buffer(buffer)

func set_buffer(size: int):
	buffer = size
	minBound = Vector2(-buffer, -buffer)
	maxBound = Vector2(screen_size.x + buffer, screen_size.y + buffer)	

func _physics_process(delta: float):
	move_and_slide(Vector2(speed * delta,0).rotated(rotation))

func _process(delta: float):
	if (global_position.x < minBound.x || global_position.x -1 > maxBound.x || 
			global_position.y < minBound.y || global_position.y -1 > maxBound.y):
		print("bye-bye from ", get_instance_id())
		queue_free()
