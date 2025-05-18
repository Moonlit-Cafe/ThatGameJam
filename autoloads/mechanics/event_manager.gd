extends Node

#region Built-Ins
func _ready() -> void:
	GameGlobalEvents.start_event.connect(_on_event_started)
#endregion

#region Event Methods
## Starts the Nomad Event
func start_event_nomad() -> void:
	print("Nomad Event Started . . .")
#endregion

#region Signal Callbacks
## Used in combination with the [signal GameGlobalEvents.start_event] signal in GameGlobalEvents to 
## start a new event.
## TODO: Look into possibly making events resource based, initial idea is to have stat changes made by resource
## but then anything complex handled by start_event_[...] method in this script.
func _on_event_started(event: Genum.Events) -> void:
	match(event):
		Genum.Events.NOMAD:
			start_event_nomad()
		_:
			push_warning("There is no Event by id: %s" % event)
#endregion
