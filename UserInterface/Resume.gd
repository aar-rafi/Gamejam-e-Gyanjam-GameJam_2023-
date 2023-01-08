extends Button


onready var pause_overlay:  = get_tree() 

func _on_button_up():
	get_tree().paused = false
	get_node("../../../PauseOverlay").visible = false
	get_node("../../../bgSound").playing = false
	
