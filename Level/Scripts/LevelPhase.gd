extends Node2D

class_name LevelPhase

signal phase_ended

func start_phase():
	pass

func _end_phase():
	emit_signal("phase_ended")
