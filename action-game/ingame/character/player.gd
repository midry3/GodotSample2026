extends CharacterBase
class_name Player

@export var on_air_vx := 100

@onready var died_se := $DiedSE

var died_player := preload("uid://d011j3n7t7wki")

func _input(event):
	if GameManager.get_current_stage().current_state != StageBase.State.PLAY: return
	handle_key()
	if is_on_floor():
		if Input.get_axis("left", "right") == 0:
			to_idle()
		if event.is_action_pressed("jump"):
			jump()

func handle_key() -> void:
	var d := Input.get_axis("left", "right") # (-1, 1)の係数を取る
	if is_on_floor():
		velocity.x = walk_speed * d
		if d == 1:
			walk_right()
		elif d == -1:
			walk_left()
		else:
			to_idle()
	else:
		Input.get_axis("left", "right") # (-1, 1)の係数を取ってかける
		velocity.x = walk_speed * d
		if d == 1: to_right()
		elif d == -1: to_left()

func _on_jump_finished():
	handle_key()

func die() -> void:
	# die関数をオーバーライド
	current_state = State.DIED
	velocity = Vector2.ZERO
	accelation = Vector2.ZERO
	anim.hide()
	var d := died_player.instantiate()
	d.global_position = global_position
	died_se.play()
	GameManager.get_current_stage().add_child(d)
	GameManager.get_current_stage().game_over()
