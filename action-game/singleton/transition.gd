extends Node

var loading_screen := preload("uid://bwu7uhfesy537") # ローディング画面のシーン
var next_scene := ""

func request_trans_to(scene: String) -> void:
	next_scene = scene
	ResourceLoader.load_threaded_request(next_scene)
	var t := create_tween()
	t.tween_property(get_tree().current_scene, "modulate:a", 0, 0.5)
	t.tween_callback(
		func():
			get_tree().change_scene_to_packed(loading_screen)
	)

func try_trans() -> void:
	if is_load_finished():
		var scene := ResourceLoader.load_threaded_get(next_scene)
		if scene == null: return # たまにnullが返ってくる
		var t := create_tween()
		t.tween_property(get_tree().current_scene, "modulate:a", 0, 0.5)
		t.tween_callback(
			func():
				get_tree().change_scene_to_packed(scene)
		)

func is_load_finished() -> bool:
	match ResourceLoader.load_threaded_get_status(next_scene):
		ResourceLoader.THREAD_LOAD_LOADED:
			return true
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			return false
		_:
			return false
