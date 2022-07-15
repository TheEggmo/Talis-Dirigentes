class_name Player
extends Unit

export var coyote_time = .07
export var jump_buffer = .1

export var max_jumps = 1
onready var jumps_left = max_jumps

func _physics_process(delta):
	if is_on_ceiling():
		velocity.y = max(0, velocity.y)
	if is_on_wall():
		velocity.x = 0
	if !is_on_floor() && $CoyoteTimer.is_stopped():
		$CoyoteTimer.start(coyote_time)
	if is_on_floor():
		jumps_left = max_jumps
	
	var h_direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	h_movement(delta, h_direction)
	
	# Flip sprite
	if h_direction > 0:
		$Sprite.flip_h = false
		$GunPivot.rotation_degrees = 0
	elif h_direction < 0:
		$Sprite.flip_h = true
		$GunPivot.rotation_degrees = 180
	
	# Fall cancel
	if !is_on_floor() and Input.is_action_just_released("jump"):
		velocity.y = max(velocity.y,velocity.y / 2)
	
	if Input.is_action_just_pressed("jump"):
		$JumpBufferTimer.start(jump_buffer)
	
	if (is_on_floor() || !$CoyoteTimer.is_stopped()) && !$JumpBufferTimer.is_stopped() && jumps_left > 0:
		jump()
		$CoyoteTimer.stop()
		$JumpBufferTimer.stop()
		jumps_left -= 1
	
	move()

#func coyote_remaining():
#	return walkOffTime == null || get_time() - walkOffTime < coyoteTime
#
#func get_time():
#	return OS.get_ticks_msec() / 1000.0
