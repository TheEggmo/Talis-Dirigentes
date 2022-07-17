class_name Bullet
extends Node2D

var direction :Vector2
export var move_speed = 10

var piercing = false
var explosive = false
var launches_dice = false

var explosion_scene = preload("res://Objects/Explosion/Explosion.tscn")

#func _ready():
#	if launches_dice:
#		$WallDetector.set_collision_mask_bit(6, true)

func _physics_process(delta):
	position += direction * move_speed * (delta+1)

func _on_Hitbox_body_entered(body):
	# Enemy collision
	if body is Unit:
		if explosive:
			explode()
		else:
			body.lose_hp(1)
	if !piercing:
		queue_free()

func explode():
	var instance = explosion_scene.instance()
	instance.global_position = global_position
	get_tree().get_root().add_child(instance)


func _on_WallDetector_body_entered(body):
	if body is RigidBody2D:
		# Dice collision
		if LevelUp.can_juggle:
			if explosive:
				explode()
			queue_free()
	else:
		# Wall collision
		if explosive:
			explode()
		queue_free()
	

