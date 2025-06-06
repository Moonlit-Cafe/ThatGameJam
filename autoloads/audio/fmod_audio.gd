extends Node

#region Variables
var event_list : Dictionary[StringName, String] = {
	&"desertSunrise": "event:/ost/desertSunrise",
	&"dialogue": "event:/ost/dialogue",
	&"menu1": "event:/ost/menu1",
	&"menu2": "event:/ost/menu2",
	&"ant": "event:/sfx/ant",
	&"falcon": "event:/sfx/falcon",
	&"grassClick": "event:/sfx/grassClick",
	&"leafClick": "event:/sfx/leafClick",
	&"menuClick": "event:/sfx/menuClick",
	&"menuHover": "event:/sfx/menuHover",
	&"mouse": "event:/sfx/mouse",
	&"sandClick": "event:/sfx/sandClick",
	&"wind": "event:/sfx/wind"
}
var event_holder : Array[Array] = []
var ost_count : int = 1
var sfx_count : int = 3
#endregion

#region Built-Ins
func _ready() -> void:
	_create_event_holders()
	
	GameGlobalEvents.volume_changed.connect(_on_volume_changed)

func _process(_delta: float) -> void:
	_check_events()
#endregion

#region Setup
func _create_event_holders() -> void:
	for ost_event in range(ost_count):
		var event : FmodEvent = null
		event_holder.append([event, ""])
	
	for sfx_event in range(sfx_count):
		var event : FmodEvent = null
		event_holder.append([event, ""])

func _check_events() -> void:
	for event in event_holder:
		if event[0]:
			if event[0].get_playback_state() == 2:
				event[0] = null
				event[1] = ""
#endregion

#region Public Methods
func play(sound: StringName) -> void:
	if not sound in event_list:
		printerr("There is no sound %s in listed events" % sound)
		return
	
	var sound_path : String = event_list.get(sound)
	if sound_path.contains("ost"):
		for event in range(ost_count):
			if not event:
				_create_sound(sound, event, 1)
				return
	
	if sound_path.contains("sfx") and not sound_path.contains("menu"):
		for event in range(sfx_count):
			if not event:
				_create_sound(sound, event + ost_count)
				return
	else:
		for event in range(sfx_count):
			if not event:
				_create_sound(sound, event + ost_count, 3)
				return

func stop(sound: StringName) -> void:
	for event in event_holder:
		if event[1] == sound:
			event[0].stop()
#endregion

#region Helpers
func _create_sound(sound: StringName, event_value: int, bus_id: int = 2) -> void:
	event_holder[event_value][0] = FmodServer.create_event_instance(event_list.get(sound))
	event_holder[event_value][0].volume = AudioServer.get_bus_volume_linear(bus_id)
	event_holder[event_value][1] = sound
	event_holder[event_value][0].start()
#endregion

#region Signal Callbacks
func _on_volume_changed(bus_id: int) -> void:
	var allowed_to_change := false
	
	for event in range(event_holder.size()):
		if event < ost_count and bus_id == 1:
			allowed_to_change = true
		elif event < sfx_count and bus_id == 2:
			if event_holder[event][1].contains("menu"):
				continue
			allowed_to_change = true
		elif event < sfx_count and bus_id == 3 and event_holder[event][1].contains("menu"):
			allowed_to_change = true
		
		if allowed_to_change:
			event_holder[event][0].volume = AudioServer.get_bus_volume_linear(bus_id)
			allowed_to_change = false
#endregion
