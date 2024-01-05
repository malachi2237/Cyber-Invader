extends Node

class_name GameManager

export(Array, PackedScene) var stage_queue: Array
export(NodePath) var player

var player_reference

func _ready() -> void:
	call_deferred("_switch_phase")

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		return
func _switch_phase():
	if !stage_queue.empty():
		var phase_instance: LevelPhase = _popNextPhase()
		Utility.placeInScene(self, phase_instance, null)
		_connectPhase(phase_instance)

func _popNextPhase() -> Node:
	return stage_queue.pop_front().instance()

func _connectPhase(phase_instance: LevelPhase) -> void:
	var _toss = phase_instance.connect("phase_ended", self, "_switch_phase")

func _switchScene() -> void:
	pass
