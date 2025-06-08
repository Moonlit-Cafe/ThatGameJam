extends TabContainer

#region Node References
@export var button_container : VBoxContainer
@export_category("Debug Tab")
@export var pause_tick_button : Button
#endregion

#region Variables
var open := false
var _parent : CanvasLayer
#endregion

#region Built Ins
func _ready() -> void:
	_parent = get_parent().get_parent()
	
	for button_idx in range(button_container.get_child_count()):
		button_container.get_child(button_idx).pressed.connect(_on_button_pressed.bind(button_idx))
#endregion

#region Button Callbacks
func _on_button_pressed(idx: int) -> void:
	if not open:
		_parent.open_data_panel()
	elif current_tab == idx:
		_parent.close_data_panel()
	
	current_tab = idx
#endregion

#region Debug Callbacks
func _on_pause_game_tick() -> void:
	GameGlobal.paused = !GameGlobal.paused
	
	if GameGlobal.paused:
		pause_tick_button.text = "Toggle Game Ticks: not ticking"
	else:
		pause_tick_button.text = "Toggle Game Ticks: ticking"
#endregion
