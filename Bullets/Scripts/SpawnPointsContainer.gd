extends Node2D

export(int) var spawn_point_count = 1

#TODO: (?) maybe remove initial rotation
# redundant design data
export(float) var initial_rotation = 0.0

#TODO:These are part of the Arc Spawn Shape
#WARNING: this tasks will delete design data!!
export(float) var radius = 1.0
export(float) var arc_size = 360.0

#TODO: Replace with a better spawn Shape selector
export(int) var spawnShapeOption = 0

#TODO: rename rotation_speed to speed to include more movement patterns
#TODO: Possibly place this design component onto the movements directly
#WARNING: these tasks will delete design data!!
export(float) var rotation_speed = 0.0

#TODO: Introduce Spawn Movement Patterns
#spawnMovementPattern
#Types:
#Rotator : implemented
#Patrols : TODO

#TODO: make Movement Option Picker
onready var spawn_movement: SpawnMovementPattern = SpawnMovementRotation.new()

#TODO: Easier type management of spawnShape, match is *very* manual
#TODO: Static shape builder?
onready var spawn_shape: SpawnShape = _makeSpawnShape()
func _makeSpawnShape() -> SpawnShape:
	match spawnShapeOption:
		SpawnShapes.ARC: return SpawnShapeArc.new()
		SpawnShapes.BOX: return SpawnShape.new()
	return SpawnShape.new()

onready var _step: float = spawn_shape.solveSteps(spawn_point_count)

#TODO: replace this enum with the better Shape Picker
enum SpawnShapes{
	ARC, BOX,
}

func _ready():
	#TODO: Below is a design patch until movement pattern solution
	spawn_movement.speed = rotation_speed
	_makeSpawnPoints()
	_setInitialRotation()

func _process(delta):
	spawn_movement.doMovement(delta)

#TODO: (?) redundant design tool, can instead use inspector transforms
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
