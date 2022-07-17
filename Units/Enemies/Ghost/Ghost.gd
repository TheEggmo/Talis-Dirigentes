extends Enemy

#export var move_speed = 2

onready var player :Player = get_tree().get_nodes_in_group("Player")[0]

func _physics_process(delta):
	if is_instance_valid(player):
		global_position = global_position.move_toward(player.global_position, move_speed)
		if player.global_position < global_position:
			$Sprite.flip_h = true
		else:
			$Sprite.flip_h = false
	
	if hp <= 0:
		destroy()

func destroy():
	spawn_xp()
	spawn_xp()
	.destroy()
