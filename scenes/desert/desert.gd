extends Node2D
@onready var parallaxBackground = $ParallaxBackground

func _physics_process(delta: float) -> void:
	parallaxBackground.scroll_offset.x += 1
	
