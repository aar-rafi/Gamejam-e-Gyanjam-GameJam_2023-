extends Control


#onready var label: Label = $Label


func _ready()->void:
	#label.text = label.text % [PlayerData.score, PlayerData.death]
	#PlayerData.score = 0 
	PlayerData.death = 0
	
