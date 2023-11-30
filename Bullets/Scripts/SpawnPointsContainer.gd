extends Node2D

export(int) var spawn_point_count = 1

#TODO: Remove initial rotation, redundant design data
#WARNING: this task will delete design data!!
export(float) var initial_rotation = 0.0

#TODO:Place these on Arc Spawn Shape
#WARNING: this task will delete design data!!
export(float) var radius = 1.0
export(float) var arc_size = 360.0

#TODO: Replace with a better spawn Shape selector
export(int) var spawnShapeOption = 0

#TODO: Place rotation speed onto the rotation movements directly
#WARNING: this task will delete design data!!
export(float) var rotation_speed = 0.0

#TODO: Make Movement Designer
onready var spawn_movement: SpawnMovementPattern = SpawnMovementRotation.new()

#TODO: Make Spawn Shape Designer
onready var spawn_shape: SpawnShape = _makeSpawnShape()
func _makeSpawnShape() -> SpawnShape:
	match spawnShapeOption:
		SpawnShapes.ARC: return SpawnShapeArc.new()
		SpawnShapes.BOX: return SpawnShape.new()
	return SpawnShape.new()

onready var _step: float = spawn_shape.solveSteps(spawn_point_count)

#TODO: Make Spawn Shape Designer
enum SpawnShapes{
	ARC, BOX,
}

func _ready():
	#TODO: Below is a bandaid until Movement Designer
	spawn_movement.speed = rotation_speed
	_makeSpawnPoints()
	_setInitialRotation()

func _process(delta):
	spawn_movement.doMovement(delta)

#TODO: Remove initial rotation, redundant design data
#WARNING: this tasks will delete design data!!
func _setInitialRotation():
	self.rotate(deg2rad(initial_rotation))

func _makeSpawnPoints() -> void:
	for current_spawn_point in range(spawn_point_count):
		self.add_child(_newSpawnPoint(
					spawn_shape.getPoint(_step, current_spawn_point)))

func _newSpawnPoint(pos) -> Node2D:
	var spawn_point = Node2D.new()
	spawn_point.position = pos
	spawn_point.rotation = pos.angle()
	return spawn_point
