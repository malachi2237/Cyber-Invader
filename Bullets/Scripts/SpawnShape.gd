extends Node

class_name SpawnShape

onready var _step: float

func solvePosition(factor):
	return Vector2.ZERO * _step * factor

func solveSteps(spawn_count: int) -> void:
	_step = float(spawn_count)
