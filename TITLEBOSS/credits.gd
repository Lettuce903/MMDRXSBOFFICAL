extends Node2D

func _ready():
	GameHUD.player_vital_bar.hide()
	GameHUD.player_weapon_bar.hide()

func _on_FadeScreen_fading_finished():
	$AnimationPlayer.play("New Anim")


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://TITLEBOSS/Title.tscn")
