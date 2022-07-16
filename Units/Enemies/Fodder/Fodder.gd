extends Unit

var walk_direction

func _ready():
	walk_direction = 1
	hp = 1

func _physics_process(delta):
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
		queue_free()


func _on_Hurtbox_area_entered(area):
	hp -= 1

