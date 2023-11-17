extends Node2D

export(float) var arc_size = 360.0
export(int) var spawn_point_count = 1
export(float) var initial_rotation = 0.0
export(float) var radius = 1.0
export(int) var spawnShape = 0
export(float) var rotation_speed = 0.0

enum SpawnShapes{
	ARC,
	BOX
}


onready var _step: float = solveStepsOnArc()

#---------------------------------------
func _ready():
	_makeSpawnPoints()
	_setInitialRotation()

func _process(delta):
	_rotatorSpins(delta)
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
# TODO: Reconsider assumption of circular shape
func _makeSpawnPoints() -> void:
	for current_spawn_point in range(spawn_point_count):
		self.add_child(_newSpawnPoint(_positionOnArc(_step, current_spawn_point)))

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
