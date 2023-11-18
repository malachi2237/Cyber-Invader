extends LevelPhase

class_name WavePhase

export(bool) var auto_start = false

#TODO: Some Design Class "X" that makes these three arrays into one
export(Array, PackedScene) var spawn_groups:Array
export(Array, NodePath) var spawn_points: Array
export(Array, float) var spawn_delays: Array

onready var spawn_timer: Timer = $SpawnTimer

func _ready():
	if (notEmptyCondition() and equalSizeCondition()):
		autoStartPhase()
	else:
		phaseError()

func _start_phase():
	spawn_timer.start(spawn_delays.pop_front())

func _end_phase():
	._end_phase()
	queue_free()

func notEmptyCondition() -> bool:
	return !spawn_points.empty()

func equalSizeCondition() -> bool:
	return (spawn_points.size() == spawn_groups.size() and
		 spawn_points.size() == spawn_delays.size())

func phaseError() -> void:
	printerr("Spawn stacks do not contain the same amount of elements")
	queue_free()

func autoStartPhase() -> void:
	if auto_start:
		_start_phase()

func _spawn_next_group():
	Utility.placeInScene(self, _popNextGroup(), _popNextSpawnPoint())
	_continueThroughSpawns()

func _popNextGroup():
	return spawn_groups.pop_front().instance()

func _popNextSpawnPoint() -> Vector2:
	var spawn_point: Node2D = get_node(spawn_points.pop_front())
	return spawn_point.global_position

func _continueThroughSpawns() -> void:
	if spawn_delays.empty():
		_end_phase()
	else:
		_start_phase()

func _on_SpawnTimer_timeout() -> void:
	_spawn_next_group()

