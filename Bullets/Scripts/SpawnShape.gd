extends Node


class_name SpawnShape

export onready var step: float

func _ready() -> void:
	pass

func getPoint(factor):
	return Vector2.ZERO * step * factor

func solveSteps(spawn_count: int) -> float:
	return float(spawn_count)
