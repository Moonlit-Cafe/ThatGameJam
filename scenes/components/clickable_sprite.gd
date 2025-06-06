class_name ClickableSprite extends Area2D

signal interact

# TODO: Document all of this

@export var sprite : Texture2D
@export var collision_rect : RectangleShape2D

func _ready() -> void:
	if sprite:
		$Sprite2D.texture = sprite
	
	if collision_rect:
		$CollisionShape2D.shape = collision_rect

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			interact.emit()
