extends PathFollow2D

@export_category(&"Variables")
@export var move_speed : float = 20.0
@export var time_delta : float = 1.0
@export var wait_time : float = 5.0
@export var wait_point := Vector2(0, 0)
@export_category(&"Child References")
@export var d_comp : DialogComponent

var _paused = false

# TODO: Cleanup for better generalization
func _ready() -> void:
	$ClickableSprite.interact.connect(_on_interacted)
	$Timer.timeout.connect(_on_timer_timeout)
	$Timer.start(time_delta)
	GameGlobalEvents.pause_game.connect(func(): _paused = true)
	GameGlobalEvents.resume_game.connect(func(): _paused = false)

func _on_interacted() -> void:
	if _paused:
		return
	
	if d_comp:
		d_comp.start()
	else:
		print("Hello There.")

# TODO: Most likely remove this in favor of a Global Timer that acts like a 'tick'
func _on_timer_timeout() -> void:
	if _paused:
		return
	
	progress += move_speed
	if position.distance_to(wait_point) <= 1:
		$Timer.start(wait_time)
	else:
		$Timer.start(time_delta)
	
	print(position)
