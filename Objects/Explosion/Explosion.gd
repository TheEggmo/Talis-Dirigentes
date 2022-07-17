extends Node2D

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

func _ready():
	AudioManager.play("res://Audio/explosion1.wav")
