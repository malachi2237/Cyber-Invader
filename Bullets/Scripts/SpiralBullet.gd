extends ForwardBullet

export var _initial_rotation: float
export var _rotation_rate: float

# Called when the node enters the scene tree for the first time.
func _ready():
	rotate(deg2rad(_initial_rotation))

func _apply_movement(var delta: float) -> void:
	._apply_movement(delta)
	rotate(deg2rad(_rotation_rate * delta))

#have rotation_rate apply in opposite direction to _initial_rotation
