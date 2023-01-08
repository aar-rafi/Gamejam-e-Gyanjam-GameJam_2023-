extends Control


onready var chef:= get_node("../../Chef")
onready var text:= $TextureRect

func _physics_process(delta):
	var aim = chef.aiming
	text.rect_size.x = aim *32
	if aim == 0:
		text.visible = false
