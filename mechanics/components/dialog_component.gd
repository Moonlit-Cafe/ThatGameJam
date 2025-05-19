class_name DialogComponent extends Node

@export var dialog : DialogicTimeline

func start() -> void:
	if dialog:
		Dialogic.start(dialog)
