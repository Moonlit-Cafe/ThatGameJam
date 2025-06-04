extends Node

# TODO: Render to a ui and also change based on interact events. Probably pass through GGE

#region Variables
var current_stage : Genum.GameStages = Genum.GameStages.SEEDLING
var max_vitality : int = 2
var vitality : int = 2
var vitality_regen : int = 120
#endregion
