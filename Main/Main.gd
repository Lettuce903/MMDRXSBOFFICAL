extends Node

func _ready():
	GameHUD.player_vital_bar.hide()
	GameHUD.player_weapon_bar.hide()
	get_tree().change_scene("res://TITLEBOSS/BOSS.tscn")
