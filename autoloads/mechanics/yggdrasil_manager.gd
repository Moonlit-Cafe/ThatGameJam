extends Node

# TODO: Render to a ui and also change based on interact events. Probably pass through GGE

#region Variables
var max_esssence : int = 2
var essence : int:
	get:
		return ess_fl / 1
	set(value):
		ess_fl = value * 1.
var ess_fl : float = 0.0
var essence_regen : float = 0.1
var dew : int = 0
var hills : int = 0
var burrows : int = 0
var nests : int = 0
#endregion

#region Built-Ins
func _ready() -> void:
	GameGlobalEvents.game_tick.connect(func(): ess_fl += essence_regen)
#endregion
