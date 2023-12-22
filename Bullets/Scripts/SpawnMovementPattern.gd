extends Node2D

class_name SpawnMovementPattern

var speed: float = 1.0

func _physics_process(delta: float) -> void:
	doMovement(delta)

func doMovement(_delta: float) -> void:
	return
