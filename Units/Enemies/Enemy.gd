class_name Enemy
extends Unit

var xp_scene = preload("res://Objects/XP/XP.tscn")

func spawn_xp():
	var xp_instance = xp_scene.instance()
	xp_instance.global_position = global_position
	get_tree().get_nodes_in_group("XPGroup")[0].add_child(xp_instance)

func destroy():
	spawn_xp()
	queue_free()
