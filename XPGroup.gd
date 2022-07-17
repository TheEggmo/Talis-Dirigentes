extends Node2D

export var testing = true

func _ready():
	if !testing:
		for c in get_children():
			c.queue_free()
