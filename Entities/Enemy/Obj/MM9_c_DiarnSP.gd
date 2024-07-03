extends EnemyCore

const SHOT_DEGREES_INCREASE = 32
const MOVE_RANDOM_ADD_DEGREES = 45

export (PackedScene) var ballade_cracker

onready var blt_bhv := $BulletBehavior
onready var sprite_ani = $SpriteMain/Sprite/AnimationPlayer
onready var start_move_delay_timer = $StartMoveDelayTimer
onready var move_timer = $MoveTimer
onready var attack_duration_timer = $AttackDurationTimer

var current_shoot_degrees = -45
var is_attacking = false


func _ready() -> void:
	blt_point_toward_player()

func blt_point_toward_player():
	if player != null:
		var ag = self.global_position.angle_to_point(player.global_position)
		blt_bhv.angle_in_degrees = rad2deg(ag) - 180 + rand_range(-MOVE_RANDOM_ADD_DEGREES, MOVE_RANDOM_ADD_DEGREES)
		turn_toward_player()

func start_attack_loop():
	sprite_ani.play("AttackLoop")
	attack_duration_timer.start()

func _on_MoveTimer_timeout() -> void:
	sprite_ani.play("Attack")
	blt_bhv.active = false
	is_attacking = true

func _on_AttackDurationTimer_timeout() -> void:
	sprite_ani.play("Hide")
	start_move_delay_timer.start()
	is_attacking = false

func _on_StartMoveDelayTimer_timeout() -> void:
	blt_bhv.active = true
	blt_point_toward_player()
	move_timer.start()

#Fire four ballade crackers in 45 degrees angle.
func fire_ballade_crackers():
	var shoot_dir = [0, 180]
	
	for i in shoot_dir:
		var enemy_bullet = ballade_cracker.instance()
		get_parent().add_child(enemy_bullet)
		enemy_bullet.global_position = self.global_position
		enemy_bullet.bullet_bhv.angle_in_degrees = i + current_shoot_degrees
	
	current_shoot_degrees += SHOT_DEGREES_INCREASE
	
	FJ_AudioManager.sfx_combat_diarn_sp_shot.play()

func _on_ProjectileReflector_reflected() -> void:
	if not is_attacking:
		sprite_ani.play("Reflected")
