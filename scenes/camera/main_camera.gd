extends Camera2D

# TODO: Flesh out the camera to incorporate zoom and moving around.
func _ready() -> void:
	add_to_group("camera")

func get_camera_position() -> Vector2:
	return global_position
