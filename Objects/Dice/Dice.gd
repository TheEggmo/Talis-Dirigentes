extends RigidBody2D

var launch_force = 500
var additional_v_launch_force = 250

var warp = false
var launched = false setget _set_launched
var roll_speed 
var allow_bullet_launch = false setget ,_get_allow

func _ready():
	EventBus.connect("game_end", self, "set_visible", [false])

func _integrate_forces(state):
	if warp:
		global_position *= -1
		warp = false
#	print(linear_velocity)
	if launched:
		if linear_velocity.length() < 15:
			roll()
			self.launched = false
	else:
		if linear_velocity.length() > 300:
			self.launched = true
	roll_speed = 15/linear_velocity.length()
#	print(linear_velocity.length())


func _on_Area2D_body_entered(body :Unit):
	if body is Player:
		var launch_direction = body.global_position.direction_to(global_position)
		apply_central_impulse(launch_direction * launch_force - Vector2(0,additional_v_launch_force))


func roll():
#	var roll = randi()%6 + 1
	var roll = $AnimatedSprite.frame + 1
	EventBus.spawn_text("ROLL: " + str(roll), global_position)
	EventBus.emit_signal("dice_rolled", roll)
	$FaceChangeTimer.stop()
	$AnimatedSprite.frame = roll - 1


func _on_FaceChangeTimer_timeout():
	var randomrolls = false
	
	var cur_face = $AnimatedSprite.frame
	var frame_count = $AnimatedSprite.frames.get_frame_count("default")
	
	var new_face
	if randomrolls:
		new_face = randi() % frame_count
		while(new_face == cur_face):
			new_face = randi() % frame_count
	else:
		new_face = (cur_face + 1) % frame_count
		
	$AnimatedSprite.frame = new_face
	$FaceChangeTimer.start(roll_speed)

func _set_launched(val):
	launched = val
	if launched:
		$FaceChangeTimer.start(.1)
	else:
		$FaceChangeTimer.stop()

func _get_allow():
	return LevelUp.can_juggle


func _on_Area2D_area_entered(area):
	if self.allow_bullet_launch:
		var launch_direction = area.global_position.direction_to(global_position)
		apply_central_impulse(launch_direction * launch_force - Vector2(0,additional_v_launch_force))
