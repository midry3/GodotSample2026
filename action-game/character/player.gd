extends CharacterBase

@export var on_air_vx := 100

func _input(event):
	handle_key()
	if is_on_floor():
		if Input.get_axis("left", "right") == 0:
			to_idle()
		elif event.is_action_pressed("jump"):
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
		Input.get_axis("left", "right") # (-1, 1)の係数を取ってかける
		if abs(velocity.x) < SPEED_MAX:
			velocity.x += on_air_vx * d
			if d == 1: to_right()
			elif d == -1: to_left()

func _on_jump_finished():
	handle_key()
