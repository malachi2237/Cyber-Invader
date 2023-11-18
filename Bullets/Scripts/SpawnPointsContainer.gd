extends Node2D

export(float) var arc_size = 360.0
export(int) var spawn_point_count = 1
export(float) var initial_rotation = 0.0
export(float) var radius = 1.0
export(int) var spawnShapeOption = 0
export(float) var rotation_speed = 0.0



onready var spawn_shape: SpawnShape = _makeSpawnShape()
onready var _step: float = spawn_shape.solveSteps(spawn_point_count)

#TODO: Introduce Spawn Movement Patterns
#spawnMovementPattern
#Design Tools
#initialState
#Movement
#Types:
#Rotator
#Patrols

enum SpawnShapes{
	ARC,
	BOX,
}

#---------------------------------------
func _ready():
	_makeSpawnPoints()
	#TODO: adjust to an initial state of movement pattern
	_setInitialRotation()

func _process(delta):
	#TODO: adjust to a movement pattern call
	_rotatorSpins(delta)
	_fullRotationMod()
#---------------------------------------

#---------------------------------------
#TODO Easier type management of spawnShape, match is *very* manual
func _makeSpawnShape() -> SpawnShape:
	match spawnShapeOption:
		SpawnShapes.ARC: return SpawnShapeArc.new()
		SpawnShapes.BOX: return SpawnShape.new()
	return SpawnShape.new()

func _setInitialRotation():
	self.rotate(deg2rad(initial_rotation))
#---------------------------------------

#TODO: the following is a rotation movement pattern
#---------------------------------------
func _rotatorSpins(delta:float) -> void:
	if(rotation_speed > 0.0):
		self.rotation_degrees += _degreesThisCycle(delta)

func _degreesThisCycle(delta) -> float:
	return rotation_speed * delta

func _fullRotationMod() -> void:
	if(self.rotation_degrees >= 360):
		self.rotation_degrees = fmod(self.rotation_degrees, 360)
#---------------------------------------

#---------------------------------------
func _makeSpawnPoints() -> void:
	for current_spawn_point in range(spawn_point_count):
		self.add_child(_newSpawnPoint(
					spawn_shape.getPoint(_step, current_spawn_point)))

func _newSpawnPoint(pos) -> Node2D:
	var spawn_point = Node2D.new()
	spawn_point.position = pos
	spawn_point.rotation = pos.angle()
	return spawn_point
#---------------------------------------
