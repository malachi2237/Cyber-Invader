extends Node2D

onready var Spinners = [$CCWRadialSpawner, $CWRadialSpawner]

func _on_Boss_CirclePulse() -> void:
	for spinner in Spinners:
		spinner.start_firing()
