extends Bullet

export var spawn_radius: float
export var rotation_velocity: float

var _origin: Vector2

func _ready():
	_calculate_origin()
	
func _calculate_origin():
	var addend = Vector2(0, spawn_radius).rotated(deg2rad(global_rotation_degrees))
	_origin = global_position + addend
	
func _apply_movement(var delta: float):

	var forward_comp = Vector2.UP.rotated(rotation)
	forward_comp = forward_comp.normalized() * shot_speed
	
	var tangent_comp = _origin.direction_to(global_position)
	var new_rotation = tangent_comp.rotated(deg2rad(90)).angle()
	tangent_comp = tangent_comp.tangent()
	tangent_comp = tangent_comp.normalized() * rotation_velocity
	
	translate((tangent_comp) * delta)
	rotation = new_rotation
	translate((forward_comp) * delta)
