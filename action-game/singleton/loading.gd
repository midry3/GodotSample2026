extends Node2D

@onready var dot1 := $HBoxContainer/DotLabel
@onready var dot2 := $HBoxContainer/DotLabel2
@onready var dot3 := $HBoxContainer/DotLabel3

func _ready():
	var t := create_tween()
	t.tween_property(dot1, "position:y", dot1.position.y - 100, 0.2)
	t.tween_property(dot1, "position:y", dot1.position.y, 0.5).set_delay(0.2)
	t.tween_property(dot2, "position:y", dot2.position.y - 100, 0.2)
	t.tween_property(dot2, "position:y", dot2.position.y, 0.5).set_delay(0.2)
	t.tween_property(dot3, "position:y", dot3.position.y - 100, 0.2)
	t.tween_property(dot3, "position:y", dot3.position.y, 0.5).set_delay(0.2)
	t.set_loops(-1)

func _process(_delta):
	Transition.try_trans()
