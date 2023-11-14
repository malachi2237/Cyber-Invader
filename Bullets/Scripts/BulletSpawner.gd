extends Node2D

class_name BulletSpawner

export(PackedScene) var bullet_override = preload("res://Bullets/BulletTypes/Bullet.tscn")

onready var bullet_prefab = null

onready var burstDuration: Timer = $BurstDuration
onready var burstCooldown: Timer = $BurstCooldown
onready var shotTiming: Timer = $ShotTiming
onready var spawnPointsParent: Node2D = $SpawnPoints

signal stopped_firing

#----------------------------------------------
func _ready():
	_setBulletPrefab()
#---------------------------------------------

#---------------------------------------------
func _setBulletPrefab() -> void:
	if (bullet_override): bullet_prefab = bullet_override
#---------------------------------------------

#------------------------------------------------
func _volley() -> void:
	for spawnPoint in spawnPointsParent.get_children(): _addBulletAtPoint(spawnPoint)

func _addBulletAtPoint(spawnPoint) -> void:
	var bullet = bullet_prefab.instance()
	Utility.getScene(self).add_child(bullet)
	bullet.position = spawnPoint.global_position
	# rotation forward ?
	bullet.rotation = spawnPoint.global_rotation + deg2rad(90)
#------------------------------------------------

#------------------------------------------------
func start_firing():
	shotTiming.start()
	if burstDuration.wait_time: burstDuration.start()

func stop_firing():
	shotTiming.stop()
	emit_signal("stopped_firing")

func _end_burst():
	shotTiming.stop()
	if burstCooldown.wait_time: burstCooldown.start()
#-------------------------------------------------
