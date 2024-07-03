extends ReferenceRect
# warning-ignore:export_hint_type_mistmatch
export (float, 0, 1) var start_delay = 0
# warning-ignore:export_hint_type_mistmatch
export (float, 0, 1) var finish_delay = 0

onready var sprite_ani = $Sprite/AnimationPlayer
onready var door_close_timer = $DoorCloseTimer

func _on_AreaNotifier_entered_area():
	sprite_ani.play("DoorOpen")
	var delay : float
	delay = self.start_delay
	
	door_close_timer.start(delay)
func _on_DoorCloseTimer_timeout() -> void:
	sprite_ani.play("DoorClose")
