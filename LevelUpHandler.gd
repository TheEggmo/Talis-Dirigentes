extends Node

signal levelup(upg_type)
signal end_levelup

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
	pause(true)
	if player_level in [5, 10]:
		emit_signal("levelup", UpgradeType.DICE)
	elif player_level in [3,7]:
		emit_signal("levelup", UpgradeType.WEAPON)
	else:
		emit_signal("levelup", UpgradeType.PLAYER)
#	get_tree().set_pause(true)

func levelup_end(selected_option :int):
	var player :Player = get_tree().get_nodes_in_group("Player")[0]
	match selected_option:
		Options.HEALTH:
			player.hp += 3
		Options.JUMP:
			player.max_jumps += 1
		Options.AMMO:
			var gun :Gun =get_tree().get_nodes_in_group("Gun")[0]
			gun.max_bullets += 2
		Options.WEAPON1:
			print("weapon upgrade missing")
		Options.WEAPON2:
			print("weapon upgrade missing")
		Options.WEAPON3:
			print("weapon upgrade missing")
		Options.DICE:
			get_tree().get_nodes_in_group("DiceSpawner")[0].spawn_dice()
	
	emit_signal("end_levelup")
	
	pause(false)

func pause(val :bool):
	get_tree().set_pause(val)
