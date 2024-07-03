#PlayerAreaNotifier
#Code by : First
#Edited by : TheBossMan

#PlayerAreaNotifier will notify player
#when player is within area of this node.

#When in level, use Level_Up_Notifier and then connect the script function "entered area" to player 
#in order to let them regenerate to full health when level is cleared.

extends ReferenceRect

signal entered_area

export(int, "FORCED", "PLAYER INTERACTION", "DISABLED") var INTERACT_TYPE = 0
export(bool) var PLAYER_ON_FLOOR_ONLY = false

#Child nodes
onready var tap_texture = $TapTexture
onready var player = $"/root/Level/Iterable/Player"

onready var global_var = $"/root/GlobalVariables"
onready var player_stats = get_node("/root/PlayerStats")

#Temp variable
var is_player_in_area = false #Player's interaction checks

func _ready():
	expand_area()
	if !Engine.is_editor_hint():
		$Label.queue_free()

#Since Node2D and Controls are incompatible. There's no possible
#way to resize and expand its area node to fit the entire parent node.
#This code will fix and expand to full rectangle of parent node.
func expand_area():
	self.get_node("Area2D/CollisionShape2D").shape = RectangleShape2D.new()
	self.get_node("Area2D/CollisionShape2D").shape.extents = self.rect_size / 2
	self.get_node("Area2D/CollisionShape2D").position = self.rect_size / 2

#On player collides with warp area
func _on_Area2D_area_entered(area):
	if area.get_parent() is Player:
		is_player_in_area = true
		#Check if this warp zone is disabled.
		if INTERACT_TYPE == 2:
			return
		
		if INTERACT_TYPE == 0: #Forced
			entered_area()
			return
		
		if INTERACT_TYPE == 1 && Input.is_action_just_pressed("game_down"): #Interacted
			entered_area()
			return

#Check whether player exited interact area.
#By player's interaction only.
func _on_Area2D_area_exited(area):
	if area.get_parent() is Player:
		if INTERACT_TYPE == 1: #Player's interaction
			is_player_in_area = false

func entered_area():
	#Player must not die
	if player_stats.is_died:
		return
		
	emit_signal("entered_area")

