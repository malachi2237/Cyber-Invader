extends Enemy

export(float) var movement_angle = 20.0
export(float) var movement_speed = 50.0
export(bool) var facing_right = true

func _physics_process(delta) -> void:
	_byterMovement(delta)

func _byterMovement(delta) -> void:
	var direction = _setDirection()
	direction = _faceCorrectly(direction)
	translate(direction * movement_speed * delta)

func _setDirection() -> Vector2:
	return Vector2.RIGHT.rotated(deg2rad(movement_angle)).normalized()

func _faceCorrectly(direction: Vector2) -> Vector2:
	if (!facing_right):
		direction.x = -direction.x
	return direction
