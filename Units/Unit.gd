class_name Unit
extends KinematicBody2D

export var move_speed = 50
export var gravity = 13
export var jump_force = 500
export var max_fall_speed = 100
export var max_h_velocity = 500

var velocity := Vector2.ZERO

var hp = 1

func h_movement(delta, h_direction):
	# Friction
	velocity.x = clamp(velocity.x, -max_h_velocity, max_h_velocity)
	velocity.x = lerp(velocity.x, 0, 0.15)
	
	# Horizontal movement
	velocity.x += h_direction * move_speed * (delta + 1)

func jump():
	# Jumping
	velocity.y -= jump_force

func move():
	move_and_slide(velocity, Vector2.UP)

func lose_hp(val :int):
	hp -= val
	AudioManager.play("res://hit3.ogg")
