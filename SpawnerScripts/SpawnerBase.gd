extends Node2D
class_name SpawnerBase


var particle_scene: Resource = preload("res://particle/particle.tscn")

var screen_size: Vector2
var active: bool = true        # if set to false then new particles are not added to scene
var setup_done: bool = false   # intended to allow for first-time setup in _process loop

var default_speed: int = 10000 # scripts are responsible for their own speed, but based on this?

# this can be checked to see if there are still any particles alive on the screen
var active_particles: Array = []

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	print("spawner base loaded")
	
# random location on screen
func random_screen_position() -> Vector2:
	return Vector2(randi() % int(screen_size.x), randi() % int(screen_size.y))

func create_particle(pos: Vector2, rotation_degrees:int=0) -> KinematicBody2D:
	var particle: KinematicBody2D = particle_scene.instance()
	if active:
		particle.position = pos
		particle.rotation_degrees = rotation_degrees
		add_child(particle)
		active_particles.append(particle)
		#print (particle.get_instance_id(), " is alive! ", particle.position, '/', active_particles.size())
	else:
		print ("Inactive particle?!")
	return particle

func _process(delta):
	# go backwards through list and remove deleted items
	for i in range(active_particles.size()-1, -1, -1):
		if ! is_instance_valid(active_particles[i]):
			active_particles.remove(i)


			


