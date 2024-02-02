extends Area2D

class_name KillBoundary

# Called when the node enters the scene tree for the first time.
func _ready():
	var _toss = self.connect("area_exited", self, "_kill")

func _kill(area: Area2D):
	area.queue_free()

