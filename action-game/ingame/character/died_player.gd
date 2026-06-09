extends AnimatedSprite2D

func _ready():
	play()
	var t := create_tween()
	t.tween_property(self, "global_position:y", global_position.y-1400, 5.0)
