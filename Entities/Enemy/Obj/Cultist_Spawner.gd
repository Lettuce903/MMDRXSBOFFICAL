extends EnemyCore

onready var spawn_spirit_pos = $SpriteMain/SpawnSpiritPos
onready var rest_timer = $RestTimer
onready var launch_timer = $LaunchTimer
onready var sprite_ani = $SpriteMain/Ani

var powered_spirit = preload("res://Entities/Enemy/Obj/Powered_Spirit.tscn")

func _ready():
	turn_toward_player()
	_spawn_powered_spirit()

#Just change animation...
func _on_LaunchTimer_timeout():
	rest_timer.start()
	sprite_ani.play("Fire")
	
	FJ_AudioManager.sfx_combat_wheel_cutter.play()

#Spawn wheel cutter..
#Set delay timer for wheel cutter
func _on_RestTimer_timeout():
	turn_toward_player()
	_spawn_powered_spirit()
	
	launch_timer.start()
	sprite_ani.play("Producing")


func _spawn_powered_spirit():
	var spirit_enemy_obj = powered_spirit.instance()
	spirit_enemy_obj.initial_state = false
	get_parent().add_child(spirit_enemy_obj)
	spirit_enemy_obj.set_move_direction(-sprite_main.scale.x)
	spirit_enemy_obj.global_position = spawn_spirit_pos.global_position
