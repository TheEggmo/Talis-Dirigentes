extends RigidBody2D

var launch_force = 500
var additional_v_launch_force = 250

var warp = false
var launched = false

func _integrate_forces(state):
	if warp:
		global_position *= -1
		warp = false
#	print(linear_velocity)
	if linear_velocity.length() < 10 and launched:
		print("roll: " + str(randi()%6 + 1))
		launched = false

func _on_Area2D_body_entered(body :Unit):
	if body is Player:
		var launch_direction = body.global_position.direction_to(global_position)
		apply_central_impulse(launch_direction * launch_force - Vector2(0,additional_v_launch_force))
		launched = true
#		velocity += launch_direction * launch_force
#		velocity.y -= additional_v_launch_force
