class_name Gun
extends Node2D

var bullets setget _set_bullets
var max_bullets = 6

var bullet_scene = preload("res://Units/Player/Guns/Revolver/Bullet.tscn")
onready var barrel = $Sprite/Barrel

var has_upg_1 = false
var has_upg_2 = false
var has_upg_3 = false

signal update_ammo_count(val)

func _ready():
	EventBus.connect("dice_rolled", self, "reload")
	EventBus.connect("game_end", self, "queue_free")

func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		if bullets > 0:
			spawn_bullet(global_position.direction_to(barrel.global_position))
			self.bullets -= 1
			emit_signal("update_ammo_count", bullets)
		else:
			AudioManager.play("res://Audio/empty1.wav")
			EventBus.spawn_text("EMPTY", global_position)

func spawn_bullet(direction :Vector2):
	var bullet_instance = bullet_scene.instance()
	bullet_instance.direction = direction
	bullet_instance.rotation = Vector2.RIGHT.angle_to(direction)
	bullet_instance.global_position = barrel.global_position
	bullet_instance.set_as_toplevel(true)
	
	add_child(bullet_instance)
	AudioManager.play("res://Audio/shoot2.wav")

func reload(val):
	self.bullets = clamp(bullets + val, 0, max_bullets)
	AudioManager.play("res://Audio/powerup1.wav")
	
	EventBus.spawn_text("RELOAD", global_position)
	EventBus.emit_signal("update_ammo_hud", bullets)

func _set_bullets(val):
	bullets = val
	EventBus.emit_signal("update_ammo_hud", bullets)
	if bullets <= 0:
		AudioManager.play("res://Audio/empty1.wav")
