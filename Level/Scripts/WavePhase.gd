extends LevelPhase

class_name WavePhase

export(bool) var auto_start = false
export(Array, PackedScene) var spawn_group_stack: Array
export(Array, NodePath) var spawn_point_stack: Array
export(Array, float) var spawn_delay_stack: Array

var spawn_timer: Timer

func _ready():
	var non_zero_condition = !spawn_point_stack.empty()
	var equal_size_condition = (spawn_point_stack.size() == spawn_group_stack.size() and
		 spawn_point_stack.size() == spawn_delay_stack.size())
		
	if non_zero_condition and equal_size_condition:
		spawn_timer = Timer.new()
		add_child(spawn_timer)
		spawn_timer.one_shot = true
		spawn_timer.connect("timeout", self, "_spawn_next_group")
		
		if auto_start:
			_start_phase()
	else:
		printerr("Spawn stacks do not contain the same amount of elements")
		queue_free()

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
