extends Node

# TODO: Render to a ui and also change based on interact events. Probably pass through GGE

#region Variables
var max_vitality : int = 2
var vitality : int:
	get:
		return vit_fl / 10
	set(value):
		vit_fl = value * 10
var vit_fl : float = 0.0
var vitality_regen : float = 0.1
#endregion

#region Built-Ins
func _ready() -> void:
	GameGlobalEvents.game_tick.connect(func(): vit_fl += vitality_regen)
#endregion
