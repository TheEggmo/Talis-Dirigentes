extends Node2D

var player :Player
var move_speed = 5

onready var rot_speed = rand_range(-1.5,1.5)

func _physics_process(delta):
	if is_instance_valid(player):
		global_position = global_position.move_toward(player.global_position, move_speed * (1+delta))
	
	rotation_degrees += rot_speed

func _on_PlayerDetector_body_entered(body):
	if body is Player:
		player = body

func _on_VanishTimer_timeout():
	queue_free()


func _on_CollectionArea_body_entered(body):
	if body is Player:
		$VanishTimer.start()
		visible = false
		AudioManager.play("res://coin2.wav")
		$CollectionArea.queue_free()
