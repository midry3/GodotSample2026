extends Node2D

@onready var vol_slider := $GridContainer/HSlider

func _ready():
	vol_slider.value = Settings.get_volume()

func _on_close_button_pressed():
	queue_free()

func _on_h_slider_value_changed(value):
	Settings.change_volume(value)
