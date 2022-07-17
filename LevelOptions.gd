extends Control

var blacklisted_upgrades = []

var upgrades_text ={
	LevelUp.Options.HEALTH : ["Health Up", "Increases your health", LevelUp.Options.HEALTH],
	LevelUp.Options.JUMP : ["Jump Up", "Increases the amount of jumps you can perform without touching the ground.", LevelUp.Options.JUMP],
	LevelUp.Options.AMMO : ["Ammo", "Increases your maximum gun ammo.", LevelUp.Options.AMMO],
	LevelUp.Options.DICE : ["Dice up", "Gain an additional dice", LevelUp.Options.DICE],
	LevelUp.Options.WEAPON1 : ["Sixth chamber", "Rolling a 6 grants you explosive shots until you roll again.", LevelUp.Options.WEAPON1],
	LevelUp.Options.WEAPON2 : ["Snake shot", "Rolling 1 gives you piercing shots until you roll again.", LevelUp.Options.WEAPON2],
	LevelUp.Options.WEAPON3 : ["Clay pigeon", "Shooting the dice launches it and increases the next roll by 1", LevelUp.Options.WEAPON3],
}

func _ready():
	LevelUp.connect("levelup", self, "show_options")
	LevelUp.connect("end_levelup", self, "set_visible", [false])

func show_options(upg_type):
	$Panel/HBoxContainer/Option1.visible = true
	$Panel/HBoxContainer/Option2.visible = true
	$Panel/HBoxContainer/Option3.visible = true
	
	var op1
	var op2
	var op3
	
	match upg_type:
		LevelUp.UpgradeType.PLAYER:
			op1 = upgrades_text[LevelUp.Options.HEALTH]
			op2 = upgrades_text[LevelUp.Options.JUMP]
			op3 = upgrades_text[LevelUp.Options.AMMO]
		LevelUp.UpgradeType.WEAPON:
			op1 = upgrades_text[LevelUp.Options.WEAPON1]
			op2 = upgrades_text[LevelUp.Options.WEAPON2]
			op3 = upgrades_text[LevelUp.Options.WEAPON3]
		LevelUp.UpgradeType.DICE:
			op1 = upgrades_text[LevelUp.Options.DICE]
			op2 = upgrades_text[LevelUp.Options.DICE]
			op3 = upgrades_text[LevelUp.Options.DICE]
	
	$Panel/HBoxContainer/Option1.setup(op1[0], op1[1], op1[2])
	$Panel/HBoxContainer/Option2.setup(op2[0], op2[1], op2[2])
	$Panel/HBoxContainer/Option3.setup(op3[0], op3[1], op3[2])
	
	if upg_type == LevelUp.UpgradeType.WEAPON:
		if LevelUp.Options.WEAPON1 in blacklisted_upgrades:
			$Panel/HBoxContainer/Option1.visible = false
		if LevelUp.Options.WEAPON2 in blacklisted_upgrades:
			$Panel/HBoxContainer/Option2.visible = false
		if LevelUp.Options.WEAPON3 in blacklisted_upgrades:
			$Panel/HBoxContainer/Option3.visible = false
	elif upg_type == LevelUp.UpgradeType.DICE:
		$Panel/HBoxContainer/Option2.visible = false
		$Panel/HBoxContainer/Option3.visible = false
	
	
	visible = true


func _on_Option1_selected_option(val):
	blacklisted_upgrades.append(val)


func _on_Option2_selected_option(val):
	blacklisted_upgrades.append(val)


func _on_Option3_selected_option(val):
	blacklisted_upgrades.append(val)
