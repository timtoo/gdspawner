extends CanvasLayer

func _ready():
	# so we can automatically kill ourselves when out of bounds	
	get_tree().get_root().connect("size_changed", self, "on_screensize_change")
	on_screensize_change()
	
	# why connecting this signal doesn't work?? 
	$CheckButton.connect("toggled", self, "on_chaos_toggle", [true])

func on_screensize_change():
	var screen_size = get_viewport().get_visible_rect().size
	$TextureRect.set_size(screen_size)

func on_chaos_toggle(state: bool):
	print(state)
	get_parent().collision_enabled = state

# connected via editor, because in code isn't working.
func _on_CheckButton_toggled(button_pressed):
	get_parent().collision_enabled = button_pressed
	print("toggle", button_pressed)

