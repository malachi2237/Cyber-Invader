extends LevelPhase

class_name BossPhase

export (PackedScene) var Boss

func _ready():
	start_phase()
	
func start_phase():
	var boss_inst = Boss.instance()
	boss_inst.position = Vector2(2800, 500)
	add_child(boss_inst)
	#connect some signal
	pass
