extends SpawnMovementPattern

class_name SpawnMovementRotation

func doMovement(delta: float) -> void:
	_rotatorSpins(delta)
	_fullRotationMod()

func _rotatorSpins(delta:float) -> void:
	if(speed > 0.0):
		self.rotation_degrees += _degreesThisCycle(delta)

func _degreesThisCycle(delta) -> float:
	return speed * delta

func _fullRotationMod() -> void:
	if(self.rotation_degrees >= 360):
		self.rotation_degrees = fmod(self.rotation_degrees, 360)
