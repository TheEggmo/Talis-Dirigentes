extends Node2D

var bullets = 6

var bullet_scene = preload("res://Units/Player/Guns/Revolver/Bullet.tscn")

func _ready():
	EventBus.connect("dice_rolled", self, "reload")

func _physics_process(delta):
	if Input.is_action_just_pressed("shoot") and bullets > 0:
		spawn_bullet(global_position.direction_to($Gun.global_position))
		bullets -= 1
		print("Bullets: " + str(bullets))

func spawn_bullet(direction :Vector2):
	var bullet_instance = bullet_scene.instance()
	bullet_instance.direction = direction
	bullet_instance.global_position = $Gun.global_position
	bullet_instance.set_as_toplevel(true)
	add_child(bullet_instance)

func reload(val):
	bullets = val
