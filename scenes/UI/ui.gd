extends CanvasLayer

#region Node References
@export var data_panel : TabContainer

@export_category("Labels")
@export var essence_label : Label
@export var dew_label : Label
@export var hill_label : Label
@export var burrow_label : Label
@export var nest_label : Label
#endregion

#region Variables
var _open_position : Vector2
var _close_position : Vector2
var _bottom_margin : int = 100
var _right_margin : int = 10
#endregion

#region Built Ins
func _ready() -> void:
	_update_positions()
	close_data_panel()
	
	GameGlobalEvents.game_tick.connect(_on_game_tick)
#endregion

#region Public Methods
func open_data_panel() -> void:
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(data_panel, "position", _open_position, 0.5)
	data_panel.open = true

func close_data_panel() -> void:
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(data_panel, "position", _close_position, 0.5)
	data_panel.open = false
#endregion

#region Private Methods
func _update_positions() -> void:
	var window := get_tree().root.get_size_with_decorations()
	_close_position = Vector2(window.x + 100, maxi(64, window.y - (700 + 64 + _bottom_margin)))
	_open_position = Vector2(window.x - (64 + 600 + _right_margin), maxi(64, window.y - (700 + 64 + _bottom_margin)))
#endregion

#region Signal Callbacks
func _on_game_tick() -> void:
	if not (essence_label and dew_label and hill_label and burrow_label and nest_label):
		push_error("Not all labels are properly set...")
		return
	
	print(YggdrasilManager.essence)
	print(YggdrasilManager.ess_fl)
	
	essence_label.text = "Essence: %s" % YggdrasilManager.essence
	dew_label.text = "Dew: %s" % YggdrasilManager.dew
	hill_label.text = "Anthills: %s" % YggdrasilManager.hills
	burrow_label.text = "Burrows: %s" % YggdrasilManager.burrows
	nest_label.text = "Nests: %s" % YggdrasilManager.nests
#endregion
