extends Node2D

export var SnowSpawn: Array = []
var _snowBulletSpawners: Array

func _ready():
	for i in range(SnowSpawn.size()-1):
		_snowBulletSpawners.append(get_node(SnowSpawn[i]))

func _on_Boss_HyperSnow() -> void:
	for spawn in _snowBulletSpawners:
		spawn.start_firing()
