extends Node2D

export var time_to_spawn = 3
var enemy_scene = preload("res://Units/Enemies/Fodder/Fodder.tscn")
var ghost_scene = preload("res://Units/Enemies/Ghost/Ghost.tscn")

export var ghost_chance = 0.15

var spawn_ghost := false

func _ready():
	if randi() % 100 <= 100*ghost_chance:
		spawn_ghost = true
		$Sprite.self_modulate = Color8(20,20,250)

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
	var enemy_instance
	if spawn_ghost:
		enemy_instance = ghost_scene.instance()
	else:
		enemy_instance = enemy_scene.instance()
	
	enemy_instance.global_position = global_position
	var enemy_group = get_tree().get_nodes_in_group("EnemyGroup")
	if !enemy_group.empty():
		enemy_group[0].add_child(enemy_instance)


func _on_CleanupTimer_timeout():
	queue_free()
