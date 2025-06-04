extends Node

var event : FmodEvent

signal pause_game
signal resume_game
signal game_tick

func _ready() -> void:
	Dialogic.timeline_started.connect(_on_game_paused)
	Dialogic.timeline_ended.connect(_on_game_resumed)

#region Signal Callbacks
func _on_game_paused() -> void:
	pause_game.emit()
	FmodAudio.play(&"falcon")

func _on_game_resumed() -> void:
	resume_game.emit()
	
	if event:
		event.stop(0)
		event = null
