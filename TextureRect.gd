extends TextureRect

func _ready():
	# so we can automatically kill ourselves when out of bounds	
	get_tree().get_root().connect("size_changed", self, "set_screensize")
	set_screensize()

func set_screensize():
	var screen_size = get_viewport().get_visible_rect().size
	set_size(screen_size)
		
