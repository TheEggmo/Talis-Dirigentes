extends Node2D

onready var possible_positions = $Positions.get_children()
var spawner_scene = preload("res://Objects/Spawner/EnemySpawner.tscn")

func _on_SpawnTimer_timeout():
	var tries = 1
	var pos_count = possible_positions.size()
	
	var idx = randi() % pos_count
	while possible_positions[idx].get_child_count() != 0:
		idx = (idx+1) % pos_count
		tries += 1
		if tries >= pos_count:
			return
	
	var spawn_position :Position2D = possible_positions[idx]
	var spawner_instance = spawner_scene.instance()
#	spawner_instance.global_position = spawn_position.global_position
	spawn_position.add_child(spawner_instance)
