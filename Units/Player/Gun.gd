class_name Gun
extends Node2D

var bullets setget _set_bullets
var max_bullets = 6

var bullet_scene = preload("res://Units/Player/Guns/Revolver/Bullet.tscn")
onready var barrel = $Sprite/Barrel

signal update_ammo_count(val)

func _ready():
	EventBus.connect("dice_rolled", self, "reload")

func _physics_process(delta):
	if Input.is_action_just_pressed("shoot") and bullets > 0:
		spawn_bullet(global_position.direction_to(barrel.global_position))
		self.bullets -= 1
#		print("Bullets: " + str(bullets))
		emit_signal("update_ammo_count", bullets)

func spawn_bullet(direction :Vector2):
	var bullet_instance = bullet_scene.instance()
	bullet_instance.direction = direction
	bullet_instance.rotation = Vector2.RIGHT.angle_to(direction)
	bullet_instance.global_position = barrel.global_position
	bullet_instance.set_as_toplevel(true)
	add_child(bullet_instance)

func reload(val):
	self.bullets = clamp(bullets + val, 0, max_bullets)

func _set_bullets(val):
	bullets = val
	emit_signal("update_ammo_count", bullets)
