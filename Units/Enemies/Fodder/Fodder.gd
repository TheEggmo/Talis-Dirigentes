extends Unit

onready var walk_direction = 1 if randi() % 2 else -1

var xp_scene = preload("res://Objects/XP/XP.tscn")

func _ready():
	hp = 1

func _physics_process(delta):
	if walk_direction > 0:
		$Sprite.flip_h = false
	elif walk_direction < 0:
		$Sprite.flip_h = true
	
	h_movement(delta, walk_direction)
	# Gravity 
	velocity.y += gravity
	# Gravity buildup cancel
	if is_on_floor():
		velocity.y = 0
	move()
	
	if is_on_wall():
		walk_direction *= -1
		velocity.x = 0
	
	if hp <= 0:
		destroy()

func _on_Hurtbox_area_entered(area):
	lose_hp(1)

func destroy():
	var xp_instance = xp_scene.instance()
	xp_instance.global_position = global_position
	get_tree().get_nodes_in_group("XPGroup")[0].add_child(xp_instance)
	queue_free()
