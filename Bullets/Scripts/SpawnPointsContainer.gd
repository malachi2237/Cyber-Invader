extends Node2D

export(int) var spawn_point_count = 1

onready var spawn_movement: SpawnMovementPattern = $MovementPattern

onready var spawn_shape: SpawnShape = $SpawnShape

func _ready():
	spawn_shape.solveSteps(spawn_point_count)
	_makeSpawnPoints()

func _makeSpawnPoints() -> void:
	for current_spawn_point in range(spawn_point_count):
		self.add_child(_newSpawnPoint(
					spawn_shape.solvePosition(current_spawn_point)))

func _newSpawnPoint(pos) -> Node2D:
	var spawn_point = Node2D.new()
	spawn_point.position = pos
	spawn_point.rotation = pos.angle()
	return spawn_point
