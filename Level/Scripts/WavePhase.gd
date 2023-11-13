extends LevelPhase

class_name WavePhase

export(bool) var auto_start = false
export(Array, PackedScene) var spawn_group_stack: Array
export(Array, NodePath) var spawn_point_stack: Array
export(Array, float) var spawn_delay_stack: Array

var spawn_timer: Timer

func nonZeroCondition() -> bool:
	return !spawn_point_stack.empty()

func equalSizeCondition() -> bool:
	return (spawn_point_stack.size() == spawn_group_stack.size() and
		 spawn_point_stack.size() == spawn_delay_stack.size())

func phaseError() -> void:
	printerr("Spawn stacks do not contain the same amount of elements")
	queue_free()

func makePhase() -> void:
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.one_shot = true
	connectSpawnTimer()
	if auto_start: _start_phase()

func _ready():
	if nonZeroCondition() and equalSizeCondition():
		makePhase()
	else:
		phaseError()

func connectSpawnTimer() -> void:
	var _toss = spawn_timer.connect("timeout", self, "_spawn_next_group")

func _start_phase():
	spawn_timer.start(spawn_delay_stack.pop_front())

func _spawn_next_group():
	var spawn_node: Node2D = get_node(spawn_point_stack.pop_front())
	var pos = spawn_node.global_position

	var group_instance = spawn_group_stack.pop_front().instance()

	var root = get_tree().get_root()
	var current_scene = root.get_child(root.get_child_count()-1)

	current_scene.add_child(group_instance)
	group_instance.global_position = pos

	if spawn_delay_stack.empty():
		_end_phase()
		queue_free()
	else:
		spawn_timer.start(spawn_delay_stack.pop_front())