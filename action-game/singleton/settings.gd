extends Node

const SETTING_FILE := "user://setting.res"

var settings: SettingData

func _ready():
	if FileAccess.file_exists(SETTING_FILE):
		settings = load(SETTING_FILE)
	else:
		settings = SettingData.new()
	var bus := AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus, linear_to_db(settings.volume))

func save() -> void:
	ResourceSaver.save(settings, SETTING_FILE)

func get_volume() -> float:
	return settings.volume

func change_volume(vol: float) -> void:
	var bus := AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus, linear_to_db(vol))
	settings.volume = vol
	save()
