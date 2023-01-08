extends Area2D

signal activated

const TEXTURES: Dictionary = {
	'normal': preload("res://assets/buttom.png"),
	'pressed': preload("res://assets/buttom_pressed.png")
}

onready var sprite: Sprite = get_node("Sprite")

func _on_Button_player_entered(_player: KinematicBody2D) -> void:
	emit_signal("activated")
	sprite.texture = TEXTURES.pressed


func _on_Button_player_exited(_player: KinematicBody2D) -> void:
	emit_signal("activated")
	sprite.texture = TEXTURES.normal
