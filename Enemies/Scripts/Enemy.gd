extends Node2D

class_name Enemy

onready var hit_box : Area2D = $HitBox
onready var collide_box : Area2D = $CollideBox

onready var hurtAnim = $HurtAnimation
export(int) var health = 10

func _take_damage(var damage: int) -> void:
	health -= damage
	hurtAnim.play("Hurt")
	if (health <= 0):
		_die()

func _die() -> void:
	queue_free()

func _on_HitBox_area_entered(area):
	if "damage" in area:
		_take_damage(area.damage)

func _on_CollideBox_area_entered(_area):
	_take_damage(health)


func _on_HitBox_area_exited(area):
	if area is KillBoundary:
		_die()
