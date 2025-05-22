extends TextureButton

#region Node References
var container : TabContainer

@export var viewport : SubViewport
#endregion

#region Built-Ins
func _ready() -> void:
	var parent = get_parent().get_parent()
	
	# Handle Errors
	if not parent:
		push_error("Game World Viewport needs a parent to work . . .")
		return
	
	if not (parent is TabContainer):
		push_error("Game World Viewport needs a Panel type parent to work . . .")
		return
	
	# Continue Setup
	await parent.resized
	viewport.size = parent.get_rect().size
	
	container = parent

func _on_input_event(event: InputEvent) -> void:
	if not event is InputEventMouseButton or not event.is_released():
		return
	
	viewport.handle_input_locally = true
	event.position -= Vector2(container.get_rect().size.x / 2, 0)
	viewport.push_input(event, true)
	viewport.handle_input_locally = false
#endregion
