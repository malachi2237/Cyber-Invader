extends SpawnShape

class_name SpawnShapeRect

export(float) var rowCount
export(float) var colCount

func solvePosition(factor) -> Vector2:
	return _positionOnGrid(factor)

func _positionOnGrid(factor) -> Vector2:
	return _step * factor

func solveSteps(spawn_count: int)-> void:
	_step = _solveStepsOnGrid(spawn_count)

func _solveStepsOnGrid(spawn_point_count: int) -> float:
	return float(spawn_point_count)



