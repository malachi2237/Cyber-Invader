extends Enemy

export(float, 0, 1) var play_area_margin_percentage = .1

onready var warpTimer: Timer = $WarpTimer
onready var shadowClone: Sprite = $ShadowClone
onready var spriteAnim : AnimatedSprite = $GlitchySprite
onready var warpAnim: AnimationPlayer = $GlitchyAnimationPlayer
onready var bulletSpawner: BulletSpawner = $BulletSpawner

#TODO: (?) some global RNG tool
onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var newSpot: Vector2 = self.position
onready var warping: bool = false
onready var _animationList = warpAnim.get_animation_list()

func _ready() -> void:
	randomize()

func deathShot() -> void:
	#TODO: add a shoot at death bullet pattern
	pass

func _on_WarpTimer_timeout() -> void:
	if not warping:
		_ceaseFireAndLeave()
	elif warping:
		_warpIn()

func _ceaseFireAndLeave() -> void:
	_warpOut()
	bulletSpawner.stop_firing()
	spriteAnim.play("default")

func _warpOut() -> void:
	warpAnim.play("GlitchyFadeOut")

func _warpIn() -> void:
	self.position = newSpot
	warpAnim.play("GlitchyFadeIn")
	shadowClone.visible = false

func _on_GlitchyAnimationPlayer_animation_finished(_anim_name):
	if not warping:
		_prepareToWarp()
	elif warping:
		_returnAndShoot()
	warpTimer.start()

func _prepareToWarp()-> void:
	_chooseRandomSpot()
	_shadowToNewSpot()
	warping = true

#TODO: Utility? RNG Tool?
func _chooseRandomSpot() -> void:
	var play_bounds_x = Utility.get_play_area_x_bounds(self, play_area_margin_percentage)
	var play_bounds_y = Utility.get_play_area_y_bounds(self, play_area_margin_percentage)

	newSpot = Vector2(
		rng.randf_range(play_bounds_x[0], play_bounds_x[1]),
		rng.randf_range(play_bounds_y[0], play_bounds_y[1]))

func _shadowToNewSpot() -> void:
	shadowClone.visible = true
	shadowClone.global_position = newSpot

func _returnAndShoot()-> void:
	bulletSpawner.start_firing()
	spriteAnim.play("shoot")
	warping = false
