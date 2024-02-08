extends Node2D

onready var Spinners = [$CCWRadialSpawner, $CWRadialSpawner]
export (float) var rotationSpeed = 1.0


func _physics_process(delta):
	self.rotation_degrees += rotationSpeed*delta

func _on_Boss_CirclePulse() -> void:
	for spinner in Spinners:
		spinner.start_firing()
