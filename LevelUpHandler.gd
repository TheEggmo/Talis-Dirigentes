extends Node

signal levelup(upg_type)
signal end_levelup

var can_juggle = false

enum UpgradeType{
	PLAYER,
	WEAPON,
	DICE
}

enum Options{
	HEALTH,
	JUMP,
	AMMO,
	WEAPON1,
	WEAPON2,
	WEAPON3,
	DICE
}

func levelup_start(player_level):
	AudioManager.play("res://Audio/powerup3.wav")
	EventBus.emit_signal("update_lvl_hud", player_level)
	pause(true)
	if player_level in [10, 20]:
		emit_signal("levelup", UpgradeType.DICE)
	elif player_level in [4,8]:
		emit_signal("levelup", UpgradeType.WEAPON)
	else:
		emit_signal("levelup", UpgradeType.PLAYER)
#	get_tree().set_pause(true)

func levelup_end(selected_option :int):
	var player :Player = get_tree().get_nodes_in_group("Player")[0]
	var gun :Gun = get_tree().get_nodes_in_group("Gun")[0]
	match selected_option:
		Options.HEALTH:
			player.hp += 2
			EventBus.emit_signal("update_hp_hud", player.hp)
		Options.JUMP:
			player.max_jumps += 1
		Options.AMMO:
			gun.max_bullets += 2
		Options.WEAPON1:
			gun.has_upg_1 = true
		Options.WEAPON2:
			gun.has_upg_2 = true
		Options.WEAPON3:
			gun.has_upg_3 = true
			can_juggle = true
		Options.DICE:
			get_tree().get_nodes_in_group("DiceSpawner")[0].spawn_dice()
	
	emit_signal("end_levelup")
	
	pause(false)

func pause(val :bool):
	get_tree().set_pause(val)
