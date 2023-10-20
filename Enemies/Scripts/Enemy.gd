extends Area2D

class_name Enemy

onready var hitbox = $EnemyBox
onready var hurtAnim = $HurtAnimation
export(int) var health = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitoring = true

func _on_Enemy_area_entered(area):
	if ("damage" in area):
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
