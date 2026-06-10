extends CharacterBody2D
class_name CharacterBase
signal jump_finished

enum Direction {
	LEFT,
	RIGHT
}

enum State {
	NORMAL,
	JUMP,
	DIED
}

const SPEED_MAX := 900

@export var gravity := 2000 # 重力
@export var walk_speed := 700 # 歩く速度
@export var jump_power := 100 # ジャンプの初速度

@onready var anim := $AnimatedSprite2D

var current_state := State.NORMAL
var accelation := Vector2(0, gravity) # 加速度

func _ready():
	anim.play("default")

func _physics_process(delta):
	velocity += accelation * delta
	move_and_slide()
	if is_on_floor() and is_jumping():
		velocity = Vector2.ZERO
		current_state = State.NORMAL
		jump_finished.emit() # jump_finishedシグナルを呼ぶ

func to_idle() -> void:
	velocity = Vector2.ZERO
	if anim.animation != "default" and !is_jumping():
		anim.play("default")

func walk_left() -> void:
	if anim.animation != "walk" and !is_jumping():
		anim.play("walk")
	to_left()

func to_left() -> void:
	anim.flip_h = true # キャラクター画像を反転(右向きで描くため)

func walk_right() -> void:
	if anim.animation != "walk" and !is_jumping():
		anim.play("walk")
	to_right()

func to_right() -> void:
	anim.flip_h = false

func jump() -> void:
	if !is_on_floor(): return # ジャンプは床に接していないとダメ！
	if anim.animation != "jump":
		anim.play("jump")
	velocity.y = -jump_power # 上方向は負
	current_state = State.JUMP

func is_jumping() -> bool:
	return current_state == State.JUMP # velocity.y != 0 ←当初のコード

func die() -> void:
	current_state = State.DIED
	queue_free()
