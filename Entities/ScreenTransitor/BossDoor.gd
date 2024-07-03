extends ScreenTransitor

export (bool) var hide_after_opened = false

onready var sprite_ani = $Sprite/AnimationPlayer
onready var door_close_timer = $DoorCloseTimer
func _on_ScreenTransitor_transition_activated() -> void:
	sprite_ani.play("DoorOpen")
	
	#Calculates door close delay.
	var delay : float
	delay = self.start_delay + self.transit_duration.x
	
	door_close_timer.start(delay)
	
	FJ_AudioManager.sfx_env_boss_door.play()

func _on_DoorCloseTimer_timeout() -> void:
	if not hide_after_opened:
		sprite_ani.play("DoorClose")
		$AreaNotifier.INTERACT_TYPE = 2
	else:
		rect_position.x -= 16 
	
	FJ_AudioManager.sfx_env_boss_door.play()
