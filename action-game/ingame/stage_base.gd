extends Node2D
class_name StageBase

enum State {
	PLAY,
	GAME_OVER,
	GAME_CLEAR
}

@onready var canvas_layer := $CanvasLayer
@onready var player := $Player
@onready var bg_anim := $Background/AnimatedSprite2D
@onready var bgm := $AudioStreamPlayer

var current_state: State

var game_over_screen := preload("uid://cd7bul68q3inu")
var game_clear_screen := preload("uid://cxc1paxf1koda")
var settings_page := preload("uid://iyi3b34d8nmy")

func _ready():
	GameManager.set_current_stage(self, ResourceUID.path_to_uid(scene_file_path))
	current_state = State.PLAY
	bg_anim.play()

func _physics_process(delta):
	if current_state == State.PLAY and 1280 < player.global_position.y:
		player.die()

func game_over() -> void:
	if current_state != State.GAME_OVER:
		bgm.stop()
		current_state = State.GAME_OVER
		canvas_layer.add_child(game_over_screen.instantiate())

func stage_clear() -> void:
	if current_state != State.GAME_CLEAR:
		current_state = State.GAME_CLEAR
		canvas_layer.add_child(game_clear_screen.instantiate())


func _on_setting_button_pressed():
	canvas_layer.add_child(settings_page.instantiate())
