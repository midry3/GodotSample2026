extends "res://ingame/block/block_base.gd"

@export var item: PackedScene

var emitted := false

func _on_hitted():
	if emitted: return
	var i := item.instantiate()
	add_child(i)
	var t := create_tween()
	t.tween_property(i, "position:y", i.position.y-18, 1.0)
	anim.play("emitted")
	emitted = true
