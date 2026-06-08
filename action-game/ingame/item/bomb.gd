extends "res://ingame/item/item_base.gd"

func _ready():
	call_deferred("start_bomb")

func start_bomb() -> void:
	await get_tree().create_timer(1.0, false).timeout
	var t := create_tween()
	t.tween_property(self, "scale:x", 0.8, 0.5)
	t.tween_property(self, "scale:x", 1.5, 0.5)
	t.set_loops(-1)
	var t2 := create_tween()
	t2.tween_property(self, "scale:y", 1.5, 0.5)
	t2.tween_property(self, "scale:y", 0.8, 0.5)
	t2.set_loops(-1)
	anim.play("default")

func _on_animated_sprite_2d_animation_finished():
	queue_free()
