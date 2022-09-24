class_name Enemy
extends Unit

var xp_scene = preload("res://Objects/XP/XP.tscn")

func spawn_xp(pos_offset := Vector2.ZERO):
	var xp_instance = xp_scene.instance()
	xp_instance.global_position = global_position + pos_offset
	get_tree().get_nodes_in_group("XPGroup")[0].add_child(xp_instance)

func destroy():
	queue_free()
