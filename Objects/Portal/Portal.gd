extends Node2D

var ignore_list :Array

func _on_Top_body_entered(body ):
	warp(body)

func _on_Top_body_exited(body):
	remove(body)

func _on_Bottom_body_entered(body):
	warp(body)

func _on_Bottom_body_exited(body):
	remove(body)

func warp(body):
	if !ignore_list.has(body):
		add(body)
		body.global_position.y *= -1

func add(body):
	if is_instance_valid(body):
		if body is RigidBody2D:
			body.warp = true
		ignore_list.append(body)

func remove(body):
	if is_instance_valid(body):
		ignore_list.erase(body)
