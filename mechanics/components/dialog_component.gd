class_name DialogComponent extends Node

# TODO: Document

@export var dialog : DialogicTimeline

func start() -> void:
	if dialog:
		Dialogic.start(dialog)
