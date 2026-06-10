extends "res://ingame/block/block_base.gd"

@export var item: PackedScene

@onready var collision := $CollisionShape2D

var emitted := false

func _on_hitted():
	if emitted: return
	collision.disabled = true
	emitted = true
	await get_tree().create_timer(0.2).timeout
	var i := item.instantiate() as ItemBase
	i.global_position = global_position
	i.freeze = true
	GameManager.get_current_stage().add_child(i)
	var t := create_tween()
	t.tween_property(i, "position:y", i.position.y-85, 1.0)
	t.tween_callback(
		func():
			collision.disabled = false
	)
	anim.play("emitted")
