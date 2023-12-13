extends SpawnShape

class_name SpawnShapeArc

export(float) var arc_size = 360.0
export(float) var radius = 1.0

func solveSteps(spawn_count: int)-> float:
	return _solveStepsOnArc(spawn_count)

func _solveStepsOnArc(spawn_point_count: int) -> float:
	return deg2rad(arc_size) / spawn_point_count

func getPosition(factor) -> Vector2:
	return _positionOnArc(factor)

func _positionOnArc(factor) -> Vector2:
	return Vector2(radius, 0).rotated(step * factor)
