extends Gun

var explosive = false
var piercing = false

func _ready():
	self.bullets = 6

func spawn_bullet(direction :Vector2):
	var bullet_instance = bullet_scene.instance()
	bullet_instance.direction = direction
	bullet_instance.rotation = Vector2.RIGHT.angle_to(direction)
	bullet_instance.global_position = barrel.global_position
	bullet_instance.set_as_toplevel(true)
	
	bullet_instance.explosive = explosive
	bullet_instance.piercing = piercing
	bullet_instance.launches_dice = has_upg_3
	
	add_child(bullet_instance)
	AudioManager.play("res://Audio/shoot2.wav")

func reload(val):
	.reload(val)
	
	if !explosive and val == 6:
		explosive = true
	if !piercing and val == 1:
		piercing = true

func _set_bullets(val):
	._set_bullets(val)
	
	if bullets <= 0:
		explosive = false
		piercing = false
