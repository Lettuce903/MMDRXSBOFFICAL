#Projectile Reflector
#Code by First

#ProjectileReflector holds information to tell parent node of- 
#Area2D that its reflectable by either Player's projectile or
#enemy's projectile

#Used in: Enemy (res://Entities/Enemy/Obj/Enemy.tscn)
#         and Player(res://Entities/Player/Player.tscn)
#         which is a shield area.
#Within: Area2D
#Example usage can be found in res://DEV_ExampleUsages/

extends Node

class_name ProjectileReflector

signal reflected

export(bool) var enabled = true
# warning-ignore:export_hint_type_mistmatch
export(float, 0, 1) var reflect_chance = 1

#Return true if it's reflectable.
#False if not reflectable.
func do_reflect() -> bool:
	var is_success = rand_range(0.0, 1.0) < reflect_chance and enabled
	
	if is_success:
		emit_signal("reflected")
	
	return is_success
