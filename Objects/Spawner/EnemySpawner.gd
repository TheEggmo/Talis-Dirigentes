extends Node2D

export var time_to_spawn = 3
var enemy_scene = preload("res://Units/Enemies/Fodder/Fodder.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Rotate":
		time_to_spawn -= 1
		if time_to_spawn <= 0:
			$AnimationPlayer.play("Ready")
		else:
			$AnimationPlayer.play("Rotate")
	if anim_name == "Ready":
		$AnimationPlayer.play("Spawn")

func spawn():
	var enemy_instance = enemy_scene.instance()
	enemy_instance.global_position = global_position
	var enemy_group = get_tree().get_nodes_in_group("EnemyGroup")
	if !enemy_group.empty():
		enemy_group[0].add_child(enemy_instance)


func _on_CleanupTimer_timeout():
	queue_free()
