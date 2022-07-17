extends Control

func _ready():
	EventBus.connect("update_ammo_hud", self, "update_ammo")
	EventBus.connect("update_hp_hud", self, "update_hp")
	EventBus.connect("update_lvl_hud", self, "update_lvl")
	EventBus.connect("update_xp_hud", self, "update_xp")

func update_ammo(val):
	$Label.text = "AMMO:" + str(val)

func update_hp(val):
	$Label2.text = "HP:" + str(val)

func update_xp(val, val_max):
	$Label4.text = "xp: %s/%s" % [val,val_max]

func update_lvl(val):
	$Label3.text = "lvl:" + str(val)
