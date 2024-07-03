extends Node

class_name GameSettingsAudio

# warning-ignore:export_hint_type_mistmatch
export (float, -80, 0) var sfx_volume = 0 setget set_sfx_volume
# warning-ignore:export_hint_type_mistmatch
export (float, -80, 0) var bgm_volume = 0 setget set_bgm_volume

func set_sfx_volume(val):
	sfx_volume = val
	AudioServer.set_bus_volume_db(1, val)
func set_bgm_volume(val):
	bgm_volume = val
	AudioServer.set_bus_volume_db(2, val)
