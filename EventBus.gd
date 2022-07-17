extends Node

signal dice_rolled(val)
signal game_end()
#signal spawn_text(text)
signal update_ammo_hud(val)
signal update_hp_hud(val)
signal update_lvl_hud(val)
signal update_xp_hud(val, val_max)

var text_scene = preload("res://Objects/TextInstance/TextInstance.tscn")

func spawn_text(text :String, position :Vector2):
	var text_instance = text_scene.duplicate(true).instance()
	text_instance.text = text
	text_instance.global_position = position
	add_child(text_instance)
