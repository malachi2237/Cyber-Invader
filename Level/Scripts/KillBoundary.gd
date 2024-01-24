extends Area2D

class_name KillBoundary

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("area_exited", self, "_kill")

func _kill(area: Area2D):
	if not area.get_collision_layer_bit(2):
		area.queue_free()

