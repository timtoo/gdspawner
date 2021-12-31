extends Node2D

var spawner_list: Array = []

func generate(name:String, pos:Vector2 = Vector2.ZERO) -> Node2D:
	var node: Node2D = Node2D.new()
	node.set_name(name)
	node.set_script(load("res://SpawnerScripts/Spawner"+name+".gd"))
	node.position = pos
	add_child(node)
	spawner_list.append(node)
	print("Generated spawner ", name)

	return node



