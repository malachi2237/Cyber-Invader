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
export(float) var rotation_speed = 100.0
export(float) var shot_timer = .2
export(float) var radius = 100.0

export(int) var spawn_point_count = 1

export(bool) var useTimer = true

signal stopped_firing

func _ready():
	var step = deg2rad(arc_size) / spawn_point_count
	var delay_condition = initial_delay_min >= 0.0 and initial_delay_min <= initial_delay_max

	setBulletInstance()
	setUpShootTimer()
	setUpBurstTimer()

	rotator = Node2D.new()
	add_child(rotator)

	makeSpawnPoints(step)

	rotator.rotate(deg2rad(initial_rotation))
	setFireOnStart(delay_condition)

func makeSpawnPoints(step:int) -> void:
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotator.add_child(spawn_point)

func setBulletInstance() -> void:
	if (bullet_override):
		bullet_prefab = bullet_override

func setUpShootTimer() -> void:
	if useTimer:
		shoot_timer = Timer.new()
		add_child(shoot_timer)
		shoot_timer.connect("timeout", self, "_volley")

func setUpRepeatBursts() -> void:
	if !single_burst:
			interval_timer = Timer.new()
			add_child(interval_timer)
			interval_timer.one_shot = true
			interval_timer.connect("timeout", self, "start_firing")

func setUpBurstTimer() -> void:
	if enable_bursts:
		burst_timer = Timer.new()
		add_child(burst_timer)
		burst_timer.one_shot = true
		burst_timer.connect("timeout", self, "_end_burst")
		setUpRepeatBursts()

func setFireOnStart(delay_condition:bool) -> void:
	if fire_on_start and delay_condition:
		var delay = rand_range(initial_delay_min, initial_delay_max)
		var start_timer = Timer.new()

		add_child(start_timer)
		start_timer.one_shot = true
		start_timer.connect("timeout", self, "start_firing")
		start_timer.start(delay)
	elif fire_on_start:
		start_firing()

func start_firing():
	if useTimer:
		shoot_timer.start(shot_timer)

	if burst_timer:
		burst_timer.start(burst_duration)

func stop_firing():
	if useTimer:
		shoot_timer.stop()

	emit_signal("stopped_firing")

func _end_burst():
	if useTimer:
		shoot_timer.stop()
	if interval_timer:
		interval_timer.start(burst_interval)

func _process(delta):
	var new_rotation = rotator.rotation_degrees + rotation_speed * delta
	rotator.rotation_degrees = fmod(new_rotation, 360)

func _volley() -> void:
	for s in rotator.get_children():
		var bullet = bullet_prefab.instance()
		var root = get_tree().get_root()
		var scene = root.get_child(root.get_child_count()-1)

		scene.add_child(bullet)

		bullet.position = s.global_position
		bullet.rotation = s.global_rotation + deg2rad(90)
