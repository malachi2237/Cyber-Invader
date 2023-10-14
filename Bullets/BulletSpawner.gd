extends Node2D

class_name BulletSpawner

export(PackedScene) var bullet_override = preload("res://Bullets/Bullet.tscn")

onready var bullet_prefab = null

var duration_timer
var shoot_timer
var rotator

export(bool) var fire_on_start = false
export(bool) var enable_duration = false
export(float) var duration = 5.0
 
export(float) var initial_rotation = 0.0
export(float) var rotation_speed = 100.0
export(float) var shot_timer = .2
export(float) var radius = 100.0

export(int) var spawn_point_count = 1

export(bool) var useTimer = true

signal stopped_firing

func _ready():
	var step = 2 * PI / spawn_point_count

	if (bullet_override):
		bullet_prefab = bullet_override

	if useTimer:
		shoot_timer = Timer.new()
		add_child(shoot_timer)
		shoot_timer.connect("timeout", self, "_volley")

	if enable_duration:
		duration_timer = Timer.new()
		add_child(duration_timer)
		duration_timer.one_shot = true
		duration_timer.connect("timeout", self, "stop_firing")
		
		
	rotator = Node2D.new()
	add_child(rotator)

	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotator.add_child(spawn_point)

	rotator.rotate(deg2rad(initial_rotation))
	
	if fire_on_start:
		start_firing()
		
func start_firing():
	if useTimer:
		shoot_timer.start(shot_timer)
			
	if duration_timer:
		duration_timer.start(duration)
	
func stop_firing():
	if useTimer:
		shoot_timer.stop()
	
	emit_signal("stopped_firing")
		
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


