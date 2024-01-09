extends Node2D

class_name BulletSpawner

export(PackedScene) var bullet_override = preload("res://Bullets/Bullet.tscn")

onready var bullet_prefab = null

var burst_timer
var interval_timer
var shoot_timer
var rotator

export(float) var arc_size = 360.0
export(bool) var fire_on_start = true
export(float) var initial_delay_min = 0.0
export(float) var initial_delay_max = 0.0

export(bool) var enable_bursts = false
export(bool) var single_burst = false

export(float) var burst_duration = 1.0
export(float) var burst_interval = 1.0

export(float) var initial_rotation = 0.0
export(float) var rotation_speed = 0.0
export(float) var shot_timer = .2
export(float) var radius = 1.0

export(int) var spawn_point_count = 1

signal stopped_firing

#----------------------------------------------
func _ready():
	_setBulletPrefab()
	_setupShootTimer()
	_setupBurstTimer()
	_makeSpawnPoints()
	_fireOnStart()
func _process(delta):
	_rotatorSpins(delta)
#---------------------------------------------

#---------------------------------------------
func _setBulletPrefab() -> void:
	if (bullet_override): bullet_prefab = bullet_override
#---------------------------------------------

#---------------------------------------------
func _makeSpawnPoints() -> void:
	var step = deg2rad(arc_size) / spawn_point_count
	rotator = Node2D.new()
	add_child(rotator)
	for id in range(spawn_point_count):
		rotator.add_child(_newSpawnPoint(_positionOnArc(step, id)))
	rotator.rotate(deg2rad(initial_rotation))

func _newSpawnPoint(pos) -> Node2D:
	var spawn_point = Node2D.new()
	spawn_point.position = pos
	spawn_point.rotation = pos.angle()
	return spawn_point

func _positionOnArc(step, id):
	return Vector2(radius, 0).rotated(step * id)
#-----------------------------------------------

#-----------------------------------------------
func _setupShootTimer() -> void:
	shoot_timer = setupTimer(false, 0, "_volley")
#-----------------------------------------------

#-----------------------------------------------
func _setupBurstTimer() -> void:
	if enable_bursts:
		burst_timer = setupTimer(true, 0, "_end_burst")
		_setupRepeatBursts()

func _setupRepeatBursts() -> void:
	if !single_burst: interval_timer = setupTimer(true, 0, "start_firing")
#------------------------------------------------

#------------------------------------------------
func _fireOnStart() -> void:
	if fire_on_start and _delayCondition():
		var _start_timer = setupTimer(true, _randomDelay(), "start_firing")
	elif fire_on_start: start_firing()

func _delayCondition() -> bool:
	var delays_not_zero = initial_delay_min >= 0.0 and initial_delay_max > 0.0
	return delays_not_zero and initial_delay_min <= initial_delay_max

func _randomDelay() -> float:
	return rand_range(initial_delay_min, initial_delay_max)
#------------------------------------------------

#------------------------------------------------
func _rotatorSpins(delta:float) -> void:
	var new_rotation = rotator.rotation_degrees + rotation_speed * delta
	rotator.rotation_degrees = fmod(new_rotation, 360)
#------------------------------------------------

#------------------------------------------------
func _volley() -> void:
	for spawnPoint in rotator.get_children(): _addBulletAtPoint(spawnPoint)

func _addBulletAtPoint(spawnPoint) -> void:
	var bullet = bullet_prefab.instance()

	bullet.position = spawnPoint.global_position
	bullet.rotation = spawnPoint.global_rotation + deg2rad(90)
	getScene().add_child(bullet)
#------------------------------------------------

#------------------------------------------------
func start_firing():
	shoot_timer.start(shot_timer)
	if burst_timer: burst_timer.start(burst_duration)

func stop_firing():
	shoot_timer.stop()
	emit_signal("stopped_firing")

func _end_burst():
	shoot_timer.stop()
	if interval_timer: interval_timer.start(burst_interval)
#------------------------------------------------

#------------------------------------------------
func getScene():
	var root = get_tree().get_root()
	var scene = root.get_child(root.get_child_count()-1)
	return scene

func setupTimer(_one_shot, _delay, _function) -> Timer:
	var newTimer = Timer.new()
	add_child(newTimer)
	newTimer.one_shot = _one_shot
	if _delay: newTimer.start(_delay) 
	if _function: newTimer.connect("timeout", self, _function)
	return newTimer
#-------------------------------------------------
