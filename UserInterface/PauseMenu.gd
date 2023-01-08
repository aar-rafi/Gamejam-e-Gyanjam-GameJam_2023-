extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var score: Label = get_node("Label")
onready var pause_title: Label = get_node("PauseOverlay/Title")
onready var resume_bt: Button = get_node("PauseOverlay/PauseMenu/Resume")
onready var boxcont = $VBoxContainer

var paused: = false setget set_paused




func _ready()-> void:
	#PlayerData.connect("score_update", self, "update_interface")
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	#update_interface()



#func update_interface()-> void:
#	score.text = "Score: %s" % PlayerData.score
	
	
func _on_PlayerData_player_died()-> void:
	self.paused = true
	resume_bt.visible = false
	pause_title.text = "You died"

func _unhandled_input(event)->void:
	if event.is_action_pressed("pause"):
		self.paused = !paused
		if paused: $bgSound.play()
		if !paused: $bgSound.playing = false
		scene_tree.set_input_as_handled()



func set_paused(value: bool)-> void:
#	if value: 
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
	



