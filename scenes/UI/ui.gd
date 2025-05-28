extends CanvasLayer

#region Node References
@export var data_panel : TabContainer
#endregion

#region Variables
var _open_position : Vector2
var _close_position : Vector2
var _bottom_margin : int = 100
var _right_margin : int = 10
var _data_panel_opened := false
#endregion

#region Built Ins
func _ready() -> void:
	_update_positions()
	_close_data_panel()
#endregion

#region Private Methods
func _open_data_panel() -> void:
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(data_panel, "position", _open_position, 0.5)
	_data_panel_opened = true

func _close_data_panel() -> void:
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(data_panel, "position", _close_position, 0.5)
	_data_panel_opened = false

func _update_positions() -> void:
	var window := get_tree().root.get_size_with_decorations()
	print()
	_close_position = Vector2(window.x + 100, maxi(64, window.y - (700 + 64 + _bottom_margin)))
	_open_position = Vector2(window.x - (64 + 600 + _right_margin), maxi(64, window.y - (700 + 64 + _bottom_margin)))
#endregion

#region Signal Callbacks
func _on_debug_toggled() -> void:
	if _data_panel_opened and data_panel.current_tab == -1:
		_close_data_panel()
	else:
		_open_data_panel()
#endregion
