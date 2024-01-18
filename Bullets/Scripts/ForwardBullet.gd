extends Bullet

class_name ForwardBullet

func _ready():
	pass

func _apply_movement(var delta: float) -> void:
	var dir = Vector2.UP.rotated(get_global_transform().get_rotation())
	translate(dir.normalized() * shot_speed * delta)
