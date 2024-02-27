extends Node2D

class_name Enemy

onready var hit_box : Area2D = $HitBox
onready var collide_box : Area2D = $CollideBox
onready var hurtSFX = $HurtSFX
onready var hurtAnim = $HurtAnimation
onready var deathSFX = $DeathSFX

export(int) var health = 10
onready var max_health = health

var is_dead = false

func _take_damage(var damage: int) -> void:
	health -= damage
	hurtSFX.pitch_scale = rand_range(0.9, 1.1)
	hurtSFX.play()
	hurtAnim.play("Hurt")
	if health <= 0 and not is_dead:
		_die()

func _die() -> void:
	var gm = Utility.get_game_manager(self)
	gm.add_score(_calculate_score())
	deathSFX.pitch_scale = rand_range(0.5,1.5)
	deathSFX.play()
	queue_free()
	is_dead = true

func _calculate_score() -> int:
	return max_health * 1000

func _on_HitBox_area_entered(area):
	if "damage" in area:
		_take_damage(area.damage)
		area.queue_free()

func _on_CollideBox_area_entered(area):
	if(area != Utility.get_play_area(self) and area != hit_box): 
		_take_damage(health)
