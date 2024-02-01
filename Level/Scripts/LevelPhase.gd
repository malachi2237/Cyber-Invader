extends Node2D

class_name LevelPhase

signal phase_ended

export(float) var start_delay = 0.0

func ready():
	if start_delay > 0.0:
		start_after_delay()
	else:
		start_phase()
		
func start_after_delay():
	var start_timer = Timer.new()
	start_timer.one_shot = true
	start_timer.connect("timeout", self, "start_phase")
	start_timer.start(start_delay)
	
func start_phase():
	pass

func _end_phase():
	emit_signal("phase_ended")
