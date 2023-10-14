extends Enemy

export(float) var movement_angle = 20.0
export(float) var movement_speed = 50.0
export(bool) var facing_right = true

func _process(delta) -> void:
	var direction = Vector2.RIGHT.rotated(deg2rad(movement_angle))
	direction = direction.normalized()

	if (!facing_right):
		direction.x = -direction.x

	translate(direction * movement_speed * delta)

