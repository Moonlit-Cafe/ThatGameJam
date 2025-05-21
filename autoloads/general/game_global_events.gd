extends Node

signal pause_game
signal resume_game
signal game_tick

func _ready() -> void:
	Dialogic.timeline_started.connect(func(): pause_game.emit())
	Dialogic.timeline_ended.connect(func(): resume_game.emit())
