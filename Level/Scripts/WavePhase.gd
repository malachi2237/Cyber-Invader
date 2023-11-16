extends LevelPhase

class_name WavePhase

export(bool) var auto_start = false
export(Array, PackedScene) var spawn_groups:Array
export(Array, NodePath) var spawn_points: Array
export(Array, float) var spawn_delays: Array

onready var spawn_timer: Timer = $SpawnTimer

func nonZeroCondition() -> bool:
	return !spawn_points.empty()

func equalSizeCondition() -> bool:
	return (spawn_points.size() == spawn_groups.size() and
		 spawn_points.size() == spawn_delays.size())

func phaseError() -> void:
	printerr("Spawn stacks do not contain the same amount of elements")
	queue_free()

func autoStartPhase() -> void:
	if auto_start: _start_phase()

func _ready():
	if (nonZeroCondition() and equalSizeCondition()): autoStartPhase()
	else: phaseError()

func _start_phase():
	spawn_timer.start(spawn_delays.pop_front())

func _spawn_next_group():
	var spawn_node: Node2D = get_node(spawn_points.pop_front())
	var pos = spawn_node.global_position

	var group_instance = spawn_groups.pop_front().instance()

	var current_scene = Utility.getScene(self)

	current_scene.add_child(group_instance)
	group_instance.global_position = pos

	if spawn_delays.empty():
		_end_phase()
		queue_free()
	else:
		_start_phase()


func _on_SpawnTimer_timeout() -> void:
	_spawn_next_group()
