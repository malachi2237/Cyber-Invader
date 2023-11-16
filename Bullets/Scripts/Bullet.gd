extends Area2D

class_name Bullet

export var damage = 1
export var is_from_player = false

export var shot_speed = 600

#---------------------------------------------
func _physics_process(delta: float) -> void:
	_apply_movement(delta)

func _on_EndBullet_timeout() -> void:
	self.queue_free()

func _apply_movement(var delta: float) -> void:
	position.y -= shot_speed*delta
#---------------------------------------------
