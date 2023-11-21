extends Node


class_name SpawnShape

func _ready() -> void:
	pass

func getPoint(dist, factor):
	return Vector2.ZERO * dist * factor

func solveSteps(spawn_count: int) -> float:
	return float(spawn_count)
