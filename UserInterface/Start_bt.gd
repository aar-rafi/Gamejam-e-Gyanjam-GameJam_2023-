tool
extends Button


export(String, FILE) var next_scene_path: = ""

func _on_button_up():
	var scene_tree: = get_tree()
	scene_tree.change_scene(next_scene_path)
	scene_tree.paused = false
	PlayerData.score = 0

func _get_configuration_warning()-> String:
	return "next_scene_not_set" if next_scene_path == "" else ""
