extends ProgressBar

class_name HealthBar

export var target_node: NodePath
onready var enemy = get_node(target_node)

func _ready():
	if enemy is Enemy:
		max_value = enemy.health
	else:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = enemy.health
