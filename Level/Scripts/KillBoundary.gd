extends Area2D

class_name KillBoundary

# Called when the node enters the scene tree for the first time.
func _ready():
	var _toss = self.connect("area_exited", self, "_kill")

func _kill(area: Area2D):
	var area_parent = area.get_parent()
	if area_parent is Enemy:
		area_parent.queue_free()
	else:
		area.queue_free()

