extends Enemy

onready var walk_direction = 1 if randi() % 2 else -1
#var walk_direction :int

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

