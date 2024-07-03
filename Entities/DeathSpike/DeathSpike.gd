extends StaticBody2D

class_name DeathSpike
export (int) var contact_damage = 5
export (bool) var is_lava = false
func _ready():
	if is_lava == true:
		contact_damage = 30
