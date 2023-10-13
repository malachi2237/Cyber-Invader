extends Node

class_name BulletSpawner

const bullet_scene = preload("res://Bullet.tscn")

var shoot_timer
var rotator

export(float) var initial_rotation = 0
export(float) var rotation_speed = 100
export(float) var shot_timer = .2
export(float) var radius = 100

export(int) var spawn_point_count = 1

func _ready():
	var step = 2 * PI / spawn_point_count
	
	shoot_timer = Timer.new()
	rotator = Node2D.new()
	
	add_child(shoot_timer)
	add_child(rotator)
	
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotator.add_child(spawn_point)
		
	shoot_timer.wait_time = shot_timer
	shoot_timer.connect("timeout", self, "_volley")
	shoot_timer.start()

func _process(delta):
	var new_rotation = rotator.rotation_degrees + rotation_speed * delta
	rotator.rotation_degrees = fmod(new_rotation, 360)
	
func _volley() -> void:
	for s in rotator.get_children():
		var bullet = bullet_scene.instance()
		var root = get_tree().get_root()
		var scene = root.get_child(root.get_child_count()-1)
		
		scene.add_child(bullet)
		
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
