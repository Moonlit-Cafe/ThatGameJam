class_name DialogComponent extends Node

# TODO: Document

@export var dialog : DialogicTimeline

func start() -> void:
	if dialog:
		GameGlobal.start_dialog(dialog)
