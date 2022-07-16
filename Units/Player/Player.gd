class_name Player
extends Unit

export var coyote_time = .07
export var jump_buffer = .1

export var max_jumps = 1
onready var jumps_left = max_jumps

var xp = 0 setget _set_xp
var xp_req = 5
export var xp_req_ramp = 1.2
var lvl = 1

func _physics_process(delta):
	var h_direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if is_on_ceiling():
		velocity.y = max(0, velocity.y)
	if is_on_wall():
		velocity.x = 0
	if !is_on_floor() && $CoyoteTimer.is_stopped():
		$CoyoteTimer.start(coyote_time)
	if is_on_floor():
		jumps_left = max_jumps
		if h_direction != 0:
			$AnimationPlayer.play("Run")
		else:
			$AnimationPlayer.play("Idle")
	
	h_movement(delta, h_direction)
	
	# Flip sprite
#	if is_on_floor():
	if h_direction > 0:
		$Sprite.flip_h = false
		$GunPivot.rotation_degrees = 0
		$GunPivot.get_child(0).get_node("Sprite").flip_v = false
	elif h_direction < 0:
		$Sprite.flip_h = true
		$GunPivot.rotation_degrees = 180
		$GunPivot.get_child(0).get_node("Sprite").flip_v = true
	
	# Gravity
	if is_on_floor():
		velocity.y = 0
	velocity.y += gravity
	
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
		$AnimationPlayer.play("Jump")
	
	move()

func _on_XPCollector_area_entered(area):
	self.xp += 1

func _set_xp(val):
	xp = val
	
	# Check for level up
	if xp >= xp_req:
		lvl += 1
		xp -= xp_req
		xp_req *= xp_req_ramp
		print("level up: " + str(lvl))
