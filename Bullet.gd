extends Node2D

var direction :Vector2
export var move_speed = 10

func _physics_process(delta):
	position += direction * move_speed * (delta+1)


func _on_Area2D_body_entered(body):
	queue_free()



func _on_Hitbox_body_entered(body):
	if is_instance_valid(body) && body is Unit:
		body.lose_hp(1)
	queue_free()

