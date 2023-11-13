extends Node2D

class_name Enemy

onready var hit_box : Area2D = $HitBox
onready var collide_box : Area2D = $CollideBox

onready var hurtAnim = $HurtAnimation
export(int) var health = 10

func _on_hit_box_area_entered(area):
	_take_damage(area.damage)
	
func _take_damage(var damage: int) -> void:
	health -= damage
	hurtAnim.play("Hurt")
	if (health <= 0):
		_die()
	else:
		print("Hit!")

func _die() -> void:
	queue_free()
