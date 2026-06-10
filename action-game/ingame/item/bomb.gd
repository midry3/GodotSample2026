@tool

extends "res://ingame/item/item_base.gd"

@export var immediate_bomber := true
@export var fall_power := 800

@onready var smoke_anim := $SmokeAnimation
@onready var bomb_area := $SmokeAnimation/Area2D/CollisionShape2D
@onready var ignition_se := $AudioStreamPlayer2D

var is_bombering := false

func _ready():
	bomb_area.disabled = true
	smoke_anim.stop()
	smoke_anim.hide()
	if immediate_bomber:
		call_deferred("start_bomb")

func start_bomb() -> void:
	if is_bombering: return
	is_bombering = true
	await get_tree().create_timer(1.0, false).timeout
	ignition_se.play()
	var t := create_tween()
	t.tween_property(anim, "scale:x", 4, 0.5)
	t.tween_property(anim, "scale:x", 6, 0.5)
	t.set_loops(-1)
	var t2 := create_tween()
	t2.tween_property(anim, "scale:y", 6, 0.5)
	t2.tween_property(anim, "scale:y", 4, 0.5)
	t2.set_loops(-1)
	anim.play("bomber")

func _on_animated_sprite_2d_animation_finished():
	if anim.animation == "bomber":
		ignition_se.stop()
		anim.hide()
		smoke_anim.show()
		smoke_anim.play()
		await get_tree().create_timer(0.3, false).timeout
		bomb_area.disabled = false

func _on_smoke_animation_animation_finished():
	queue_free()

func _on_area_2d_body_entered(body):
	if body is CharacterBase:
		body.die()
	elif body is BlockBase:
		body.broke()

func _on_fall_area_2d_body_entered(body):
	if body is Player and !is_bombering:
		apply_impulse((body.global_position - global_position).normalized() * fall_power) # プレイヤーへの方向ベクトルを正規化
		start_bomb()
