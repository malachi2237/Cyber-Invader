extends Node

class_name GameManager

export(Array, PackedScene) var stage_queue: Array

export(NodePath) var score_counter_path
onready var score_counter: Label = get_node_or_null(score_counter_path)

var score: int = 0

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

func wipe_enemies():
	var scene = Utility.getScene(self)
	
	for child in scene.get_children():
		if child is Enemy or child is Bullet:
			child.queue_free()

func add_score(points):
	score += points
	_update_score_counter()
	
func _update_score_counter():
	score_counter.text = "%s" % score
