extends Node2D

export(float) var arc_size = 360.0
export(int) var spawn_point_count = 1
export(float) var initial_rotation = 0.0
export(float) var radius = 1.0
export(int) var spawnShapeOption = 0
export(float) var rotation_speed = 0.0

onready var spawn_shape: SpawnShape = _makeSpawnShape()
onready var _step: float = spawn_shape.()
enum SpawnShapes{
	ARC,
	BOX,
}



#---------------------------------------
func _ready():
	_makeSpawnPoints()
	_setInitialRotation()

func _process(delta):
	_rotatorSpins(delta)
#---------------------------------------

#---------------------------------------
#TODO Easier type management of shape, match is very manual
#TODO SpawnShapeArc.new() will not compile here, needs investigation
func _makeSpawnShape() -> SpawnShape:
	match spawnShapeOption:
		SpawnShapes.ARC: return SpawnShape.new()
		SpawnShapes.BOX: return SpawnShape.new()
	return SpawnShape.new()
#---------------------------------------

#---------------------------------------
func _rotatorSpins(delta:float) -> void:
	if(rotation_speed > 0.0):
		self.rotation_degrees += _degreesThisCycle(delta)
		_fullRotationMod()

func _degreesThisCycle(delta) -> float:
	return rotation_speed * delta

func _fullRotationMod() -> void:
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

func solveStepsOnArc() -> float:
	return deg2rad(arc_size) / spawn_point_count

func _positionOnArc(step, factor):
	return Vector2(radius, 0).rotated(step * factor)

func _setInitialRotation():
	self.rotate(deg2rad(initial_rotation))
#---------------------------------------
