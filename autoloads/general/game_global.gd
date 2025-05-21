extends Node

#region Variables
# TODO: Actually incorportate into Main Camera when that's ready
var zoom_level := 1
#endregion

#region Nodes
var global_timer : Timer
#endregion

#region Loading Up
func _ready() -> void:
	# Loading up sounds and then deleting the sound_loader as it's no longer necessary
	var sound_loader = SoundLoader.new()
	sound_loader.load_audio()
	sound_loader = null
	
	global_timer = Timer.new()
	add_child(global_timer)
	global_timer.timeout.connect(_on_global_timeout)
	global_timer.start(1)

#region Helpers
func delay(time: float) -> void:
	await get_tree().create_timer(time).timeout
#endregion

#region Signal Callbacks
func _on_global_timeout() -> void:
	GameGlobalEvents.game_tick.emit()
	global_timer.start(1)
#endregion
