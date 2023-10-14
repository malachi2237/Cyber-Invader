extends Node2D

class_name BulletSpawner

export(PackedScene) var bullet_override = preload("res://Bullets/Bullet.tscn")

onready var bullet_prefab = null

var shoot_timer
var rotator
onready var shotsEnabled: bool = true

export(float) var initial_rotation = 0.0
export(float) var rotation_speed = 100.0
export(float) var shot_timer = .2
export(float) var radius = 100.0

export(int) var spawn_point_count = 1

export(bool) var useTimer = true

func _ready():
	var step = 2 * PI / spawn_point_count

	if (bullet_override):
		bullet_prefab = bullet_override

	if useTimer:
		shoot_timer = Timer.new()
		add_child(shoot_timer)

	rotator = Node2D.new()
	add_child(rotator)

	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotator.add_child(spawn_point)

	rotator.rotate(deg2rad(initial_rotation))

	if useTimer:
		shoot_timer.wait_time = shot_timer
		shoot_timer.connect("timeout", self, "_volley")
		shoot_timer.start()

func _process(delta):
	var new_rotation = rotator.rotation_degrees + rotation_speed * delta
	rotator.rotation_degrees = fmod(new_rotation, 360)

func _volley() -> void:
	if not shotsEnabled:
		return
	for s in rotator.get_children():
		var bullet = bullet_prefab.instance()
		var root = get_tree().get_root()
		var scene = root.get_child(root.get_child_count()-1)

		scene.add_child(bullet)

		bullet.position = s.global_position
		bullet.rotation = s.global_rotation + deg2rad(90)


