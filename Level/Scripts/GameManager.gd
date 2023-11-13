extends Node

class_name GameManager

# Declare member variables here. Examples:
export(Array, PackedScene) var stage_queue: Array
export(NodePath) var player

var player_reference

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("_switch_phase")

func _switch_phase():
	if !stage_queue.empty():
		var next_scene: PackedScene = stage_queue.pop_front()
		var phase_instance: LevelPhase = next_scene.instance()
		var root = get_tree().get_root()
		var current_scene = root.get_child(root.get_child_count()-1)

		current_scene.add_child(phase_instance)
		connectPhase(phase_instance)

func connectPhase(phase_instance: LevelPhase) -> void:
	var _toss = phase_instance.connect("phase_ended", self, "_switch_phase")

func _switchScene() -> void:
	pass
