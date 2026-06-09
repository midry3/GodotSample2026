extends Node

var current_stage: StageBase
var current_stage_uid: String

func set_current_stage(stage: StageBase, uid: String) -> void:
	current_stage = stage
	current_stage_uid = uid

func get_current_stage() -> StageBase:
	return current_stage

func reload_stage() -> void:
	Transition.request_trans_to(current_stage_uid)
