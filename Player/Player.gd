extends KinematicBody2D

class_name Player

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var canFire: bool = true
onready var fireTimer = get_node("FireRate")
var dir: Vector2 = Vector2(0,0)
export var speed: float = 10.0
var hurt:bool = false

export(Array, NodePath) var gun_paths
export var bullet = preload("res://Bullets/PlayerBullet.tscn")

onready var guns: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for path in gun_paths:
		guns.append(get_node(path))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	DEBUG_hurt()
	movementInput()
	shoot()
	test_dead()


func _physics_process(_delta: float) -> void:
	move()

func _input(event: InputEvent) -> void:
	if event is InputEventAction:
		pass

func movementInput() -> void:
	#for analogue movement, rework to use events and device values
	#currently using "Input actions", which are strictly digital/bool
	dir = Vector2(0,0)
	dir.x += 1 if Input.is_action_pressed("player_move_right") else 0
	dir.x -= 1 if Input.is_action_pressed("player_move_left") else 0
	dir.y += 1 if Input.is_action_pressed("player_move_down") else 0
	dir.y -= 1 if Input.is_action_pressed("player_move_up") else 0
	dir = dir.normalized()

func move() -> void:
	var _a = self.move_and_collide(speed*dir)

func shoot() -> void:
	if Input.is_action_pressed("player_shoot") and canFire:
		canFire = false
		fireTimer.start()
		var root = get_tree().get_root()
		var current_scene = root.get_child(root.get_child_count()-1)
		for gun in guns:
			var bul_inst = bullet.instance()
			bul_inst.position = gun.global_position
			bul_inst.rotation = gun.global_rotation
			
			current_scene.add_child(bul_inst)


func DEBUG_hurt() -> void:
	hurt = Input.is_action_just_pressed("debug_player_hurt")

func test_dead() -> void:
	if hurt:
		get_tree().quit()

func power() -> void:
	pass

func _on_FireRate_timeout() -> void:
	canFire = true
