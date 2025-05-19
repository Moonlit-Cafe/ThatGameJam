extends PathFollow2D

@export var move_speed : float = 20.0
@export var time_delta : float = 1.0

var _paused = false

func _ready() -> void:
	$ClickableSprite.interact.connect(_on_interacted)
	$Timer.timeout.connect(_on_timer_timeout)
	$Timer.start(time_delta)
	GameGlobalEvents.pause_game.connect(func(): _paused = true)
	GameGlobalEvents.resume_game.connect(func(): _paused = false)

func _on_interacted() -> void:
	if _paused:
		return
		
	print("Hello There.")

func _on_timer_timeout() -> void:
	if _paused:
		return
	
	$Timer.start(time_delta)
	progress += move_speed
