extends KinematicBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var dir: Vector2 = Vector2(0,0)
export var speed: float = 10.0
var hurt:bool = false

export var bullet = preload("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	DEBUG_hurt()
	movementInput()
	hurt()


func _physics_process(delta: float) -> void:
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
	self.move_and_collide(speed*dir)

func shoot() -> void:
	if Input.is_action_just_pressed("player_shoot"):
		print("BANG")
		bullet.instance()


func DEBUG_hurt() -> void:
	hurt = Input.is_action_just_pressed("debug_player_hurt")

func hurt() -> void:
	if hurt:
		get_tree().quit()

func power() -> void:
	pass

