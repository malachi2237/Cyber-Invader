extends KinematicBody2D

class_name Player

var canFire: bool = true
onready var fireTimer = $FireRate
var dir: Vector2 = Vector2(0,0)
export var speed: float = 10.0
var hurt:bool = false

export(Array, NodePath) var gun_paths
export var bullet = preload("res://Bullets/PlayerBullet.tscn")

onready var guns: Array

func _ready() -> void:
	for path in gun_paths:
		guns.append(get_node(path))

func _process(_delta: float) -> void:
	_movementInput()
	if _shootPressCondition():
		_shoot()

func _physics_process(_delta: float) -> void:
	_move()

func _input(event: InputEvent) -> void:
	if event is InputEventAction:
		pass

#TODO: Fix into analogue movement
#TIP: For analogue movement, rework to use events and device values
#Currently: Using "Input actions", which are strictly digital/bool
func _movementInput() -> void:
	dir = Vector2(0,0)
	dir.x += 1 if Input.is_action_pressed("player_move_right") else 0
	dir.x -= 1 if Input.is_action_pressed("player_move_left") else 0
	dir.y += 1 if Input.is_action_pressed("player_move_down") else 0
	dir.y -= 1 if Input.is_action_pressed("player_move_up") else 0
	dir = dir.normalized()

func _move() -> void:
	var _toss = self.move_and_collide(speed*dir)

func _shootPressCondition() -> bool:
	return (Input.is_action_pressed("player_shoot") and canFire)

func _shoot() -> void:
	_shotCooldown()
	var current_scene = Utility.getScene(self)
	for current_gun in guns:
		current_scene.add_child(_makeBulletInstance(current_gun))

func _shotCooldown() -> void:
	canFire = false
	fireTimer.start()

func _makeBulletInstance(source_gun):
	var bul_inst = bullet.instance()
	bul_inst.position = source_gun.global_position
	bul_inst.rotation = source_gun.global_rotation
	return bul_inst

func die():
	queue_free()

#TODO: Implement powerups
func power() -> void:
	pass

func _on_FireRate_timeout() -> void:
	canFire = true

func _on_HitBox_area_entered(_area):
	die()
