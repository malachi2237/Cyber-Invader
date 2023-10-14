extends Bullet

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _apply_movement(var delta: float) -> void:
	var dir = Vector2.UP.rotated(get_global_transform().get_rotation())
	translate(dir.normalized() * shot_speed * delta)
