extends Position2D

var dice_scene = preload("res://Objects/Dice/Dice.tscn")

func spawn_dice():
	var dice_instance = dice_scene.instance()
	add_child(dice_instance)
