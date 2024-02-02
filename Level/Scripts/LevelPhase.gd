extends Node2D

class_name LevelPhase

signal phase_ended

export(float) var start_delay = 0.0

func _ready():
	if start_delay > 0.0:
		start_after_delay()
		
func start_after_delay():
	var _toss = Utility.setupTimer(self, true, start_delay, "start_phase")
	
func start_phase():
	pass

func _end_phase():
	emit_signal("phase_ended")
