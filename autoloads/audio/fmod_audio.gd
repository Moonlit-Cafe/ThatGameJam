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
				event_holder[event][0] = FmodServer.create_event_instance(sound_path)
				event_holder[event][0].volume = AudioServer.get_bus_volume_linear(1)
				event_holder[event][1] = sound
				event_holder[event][0].start()
				return
	
	if sound_path.contains("sfx"):
		for event in range(sfx_count):
			if not event:
				event_holder[event + (ost_count)][0] = FmodServer.create_event_instance(sound_path)
				if sound_path.contains("menu"):
					event_holder[event + (ost_count)][0].volume = AudioServer.get_bus_volume_linear(3)
				else:
					event_holder[event + (ost_count)][0].volume = AudioServer.get_bus_volume_linear(2)
				event_holder[event + (ost_count)][1] = sound
				event_holder[event + (ost_count)][0].start()
				return

func stop(sound: StringName) -> void:
	for event in event_holder:
		if event[1] == sound:
			event[0].stop()
#endregion
