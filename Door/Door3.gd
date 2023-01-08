extends StaticBody2D

export(int) var link_code: int = 0

var is_open: bool = false
var open_duration: float = 0.0

onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
onready var button_node: = get_parent().get_node("Button3")
onready var audio = $AudioStreamPlayer2D

func _ready() -> void:
	collision_shape.position = Vector2(2, 0)
	collision_shape.shape.extents = Vector2(6.6, 24)
	collision_shape.disabled = false
	animation_player.play("idle")
	
	button_node.connect("activated", self, "_change_state")
	open_duration = animation_player.get_animation("open").length
	
	
func _change_state() -> void:
	#Input.start_joy_vibration(0, 0.1, 0.05, open_duration)
	is_open =  !is_open
	if is_open:
		animation_player.play("open")
		audio.play()
		
	else:
		animation_player.play_backwards("open")
		audio.play()


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	#Input.stop_joy_vibration(0)
	if  !is_open and anim_name == "open":
		animation_player.play("idle")


