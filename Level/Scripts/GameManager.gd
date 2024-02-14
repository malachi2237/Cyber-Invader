extends Node

class_name GameManager

export(Array, PackedScene) var stage_queue: Array

export(NodePath) var score_counter_path
onready var score_counter: Label = get_node_or_null(score_counter_path)

export(NodePath) var life_counter_path
onready var life_counter: Label = get_node_or_null(life_counter_path)

export(NodePath) var death_screen_path
onready var death_screen: Panel = get_node_or_null(death_screen_path)

export(NodePath) var victory_screen_path
onready var victory_screen: ColorRect = get_node_or_null(victory_screen_path)

var score: int = 0

func _ready() -> void:
	call_deferred("_switch_phase")
	
func _switch_phase():
	if !stage_queue.empty():
		var phase_instance: LevelPhase = _popNextPhase()
		Utility.placeInScene(self, phase_instance, null)
		_connectPhase(phase_instance)
	else:
		victory_screen.update_score(score)
		victory_screen.show()

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

func _on_Player_lost_life():
	life_counter.text = "%s" % Utility.get_player(self).lives

func _on_Player_dead():
	death_screen.show()
	Utility.setupTimer(self, true, 5, "restart_scene")

func restart_scene():
	get_tree().reload_current_scene()
