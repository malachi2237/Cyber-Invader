extends Bullet

class_name SnowBullet

onready var wiggleTimer = $WiggleTimer

var right = false

func _ready():
	pass

func _apply_movement(var delta: float) -> void:
	var dir = Vector2.UP.rotated(get_global_transform().get_rotation())
	if right:
		dir += Vector2.RIGHT.rotated(get_global_transform().get_rotation())
	else:
		dir += Vector2.LEFT.rotated(get_global_transform().get_rotation())
	translate(dir.normalized() * shot_speed * delta)


func _on_WiggleTimer_timeout():
	right = not right
