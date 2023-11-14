extends Node2D

export(float) var arc_size = 360.0
export(int) var spawn_point_count = 1
export(float) var initial_rotation = 0.0
export(float) var radius = 1.0
export(float) var rotation_speed = 0.0


#---------------------------------------
func _ready():
	_makeSpawnPoints()

func _process(delta):
	_rotatorSpins(delta)
#---------------------------------------

#---------------------------------------
func _rotatorSpins(delta:float) -> void:
	if(rotation_speed > 0.0):
		var new_rotation = self.rotation_degrees + rotation_speed * delta
		self.rotation_degrees = fmod(new_rotation, 360)
#---------------------------------------

#---------------------------------------
func _makeSpawnPoints() -> void:
	# assumes circular shape
	var step = deg2rad(arc_size) / spawn_point_count
	for id in range(spawn_point_count):
		# assumes circular shape
		self.add_child(_newSpawnPoint(_positionOnArc(step, id)))
	self.rotate(deg2rad(initial_rotation))

func _newSpawnPoint(pos) -> Node2D:
	var spawn_point = Node2D.new()
	spawn_point.position = pos
	spawn_point.rotation = pos.angle()
	return spawn_point

func _positionOnArc(step, id):
	return Vector2(radius, 0).rotated(step * id)
#---------------------------------------
