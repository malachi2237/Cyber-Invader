extends SpawnShape

class_name SpawnShapeArc

export(float) var arc_size = 360.0
export(float) var radius = 1.0

func solveStepsOnArc(spawn_point_count: int) -> float:
	return deg2rad(arc_size) / spawn_point_count

func _positionOnArc(step, factor):
	return Vector2(radius, 0).rotated(step * factor)
