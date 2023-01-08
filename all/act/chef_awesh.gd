extends actors

enum{
	IDLE,
	MOVE,
	SWIM,
	THROW,
	PARACHUTE
}
var state = IDLE
var velocity = Vector2.ZERO
var max_speed = 450
var direction = Vector2.ZERO
var max_speed_in_water = 200
var w_gravity = 35

onready var fruit_scene = preload("res://all/act/Fruits.tscn")
onready var idle = $Idle
onready var move = $Move
onready var swim = $Swim
onready var throw = $Throw
onready var world = get_parent()
onready var animation = $AnimationPlayer
var aiming = 50

func _input(event):
	if event.is_action_pressed("aim") and aiming>0 and world.has_node("Fruits")==false:
		var fruit = fruit_scene.instance()
		world.add_child(fruit)
	if event.is_action_pressed("throw") and aiming >0 and world.has_node("Fruits")==true:
		aiming -= 1
		

func _physics_process(delta):
	match state:
		IDLE:
			animation.play("IDLE")
			var is_jump_interrupted: bool = Input.is_action_just_released("ui_up")and _velocity.y <0.0
			direction = get_direction()
			_velocity = calculate_move_velocity(_velocity, speed, direction, is_jump_interrupted)
			_velocity = move_and_slide(_velocity, Vector2.UP)
			move_and_collide(velocity)
			
			if get_direction().x != 0:
				state = MOVE
			if Input.is_action_pressed("throw"):
				state = THROW
			if Input.is_action_pressed("parachute") and _velocity.y > 0:
				state = PARACHUTE
		MOVE:
			if Input.is_action_pressed("parachute") and _velocity.y > 0:
				state = PARACHUTE
			if Input.is_action_pressed("throw"):
				state = THROW
			if get_direction().x == 0:
				state = IDLE
			animation.play("Run")
			var is_jump_interrupted: bool = Input.is_action_just_released("ui_up")and _velocity.y <0.0
			direction = get_direction()
			_velocity = calculate_move_velocity(_velocity, speed, direction, is_jump_interrupted)
			_velocity = move_and_slide(_velocity, Vector2.UP)
			if direction.x < 0:
				move.flip_h = true
				idle.flip_h = true
				throw.flip_h = true
			if direction.x > 0:
				move.flip_h = false
				idle.flip_h = false
				throw.flip_h = false
			move_and_collide(velocity)
		THROW:
			animation.play("Throw")
		SWIM:
			animation.play("Swim")
			var is_jump_interrupted: bool = Input.is_action_just_released("ui_up")and _velocity.y <0.0
			var direction: = get_direction()
			_velocity = calculate_move_velocity(_velocity, speed, direction, is_jump_interrupted)
			_velocity = move_and_slide(_velocity, Vector2.UP)
			if direction.x < 0:
				swim.flip_h = true
			if direction.x > 0:
				swim.flip_h = false
			move_and_collide(velocity)
		PARACHUTE:
			animation.play("Parachute")
			var is_jump_interrupted: bool = Input.is_action_just_released("ui_up")and _velocity.y <0.0
			var direction: = get_direction()
			_velocity = calculate_move_velocity_parachute(_velocity, speed, direction, is_jump_interrupted)
			_velocity = move_and_slide(_velocity, Vector2.UP)
			if direction.x < 0:
				swim.flip_h = true
			if direction.x > 0:
				swim.flip_h = false
			




#func move_state():
#	var input_vector = Vector2.ZERO
#	input_vector.x = Input.get_action_strength("ui_right")
#	input_vector.y = Input.get_action_strength("ui_down")
#
#	if input_vector != Vector2.ZERO:
#		velocity = input_vector
#	else:
#		velocity = Vector2.ZERO



func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		-1.0 if Input.get_action_strength("ui_up") and is_on_floor() else 1.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		speed: Vector2,
		direction: Vector2,
		is_jump_interrupted: bool
	)-> Vector2:
	linear_velocity.x = speed.x*direction.x
	linear_velocity.y += gravity* get_physics_process_delta_time()
	if direction.y ==-1.0:
		linear_velocity.y = speed.y * -1.0
	if is_jump_interrupted:
		linear_velocity.y = 100.0
	return linear_velocity
func calculate_move_velocity_parachute(
		linear_velocity: Vector2,
		speed: Vector2,
		direction: Vector2,
		is_jump_interrupted: bool
	)-> Vector2:
	speed = Vector2(10,100)
	linear_velocity.x = speed.x*direction.x
	linear_velocity.y += get_physics_process_delta_time()
	if direction.y ==-1.0:
		linear_velocity.y = 100.0
	if is_jump_interrupted:
		linear_velocity.y = 100.0
	return linear_velocity
func in_water():
	w_gravity = -w_gravity / 3
	max_speed = max_speed_in_water



func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "Throw"):
		state = IDLE


func _on_Area2D_area_entered(area):
	
	if area.name == "Water_Body_Area":
		state = SWIM


func _on_Area2D_area_exited(area):
	if area.name == "Water_Body_Area":
		state = IDLE



func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if state == PARACHUTE:
		state = IDLE
	pass # Replace with function body.
