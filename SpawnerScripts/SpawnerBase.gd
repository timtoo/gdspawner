extends Node2D
class_name SpawnerBase


var particle_scene: Resource = preload("res://particle/particle.tscn")

var screen_size: Vector2
var active: bool = true        # if set to false then new particles are not added to scene
var setup_done: bool = false   # intended to allow for first-time setup in _process loop
var count: int = 0             # spawers with negative count are never freed

var default_speed: int = 10000 # scripts are responsible for their own speed, but based on this?

# this can be checked to see if there are still any particles alive on the screen
var active_particles: Array = []
var we_have_particle: bool = false    # indicate that any particles have been created

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	#print("spawner base loaded (", name, ")")
	
# random location on screen
func random_screen_position() -> Vector2:
	return Vector2(randi() % int(screen_size.x), randi() % int(screen_size.y))

func random_color() -> Color:
	return Color(randf(), randf(), randf())

func create_particle(pos: Vector2, rotation_degrees:int=0) -> KinematicBody2D:
	var particle: KinematicBody2D = particle_scene.instance()
	if active:
		we_have_particle = true
		particle.position = pos
		particle.rotation_degrees = rotation_degrees
		add_child(particle)
		active_particles.append(particle)
		#print (particle.get_instance_id(), " is alive! ", particle.position, '/', active_particles.size())
		particle.get_node("CollisionShape2D").disabled = ! get_parent().get_parent().collision_enabled
	else:
		print ("Inactive particle?!")
	return particle

func set_count(i: int) -> void:
	count = i

func _process(delta):
	# go backwards through list and remove deleted particle items
	for i in range(active_particles.size()-1, -1, -1):
		if ! is_instance_valid(active_particles[i]):
			active_particles.remove(i)

	# we had particles, but none are left, so bye-bye
	if we_have_particle and active_particles.size() == 0:
		if count >= 0:
			#print("free ", name)
			get_parent().queue_free()



			


