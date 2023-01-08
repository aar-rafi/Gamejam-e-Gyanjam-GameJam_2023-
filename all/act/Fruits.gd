extends KinematicBody2D


enum{
	IDLE,
	LAUNCH
}


var state = IDLE
var fruit_velocity = Vector2.ZERO
var apple_pie = preload("res://assets/05_apple_pie.png")
var burger = preload("res://assets/15_burger.png")
var sandwich = preload("res://assets/92_sandwich.png")

var aimming = false
var total_point = 100
var fruit_gravity = 3000
var max_height = position.y + 70
var food_position = Vector2.ZERO
var rng = RandomNumberGenerator.new()
var time = 0
onready var fruit_texture = get_node("Sprite")
onready var chef:Node = get_parent().get_node("Chef")
onready var chef_particle = chef.get_node("chef_particle")
onready var collisionshape = $CollisionShape2D


var gravity = 35
var reverse_position = Vector2.ZERO

#the motion vector
#we'll use it to move our stone with move_and_slide
var motion = Vector2.ZERO

#so the stone won't accelerate forever
var max_speed = 450

var max_speed_in_water = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	random_player()

func _input(event):
	if event.is_action_pressed("aim") and !event.is_action_pressed("throw"):
		collisionshape.disabled = true
		aimming = true
	if event.is_action_released("aim"):
		#collisionshape.disabled = true
		aimming = false
		

func random_player():
	var image_players = [apple_pie, burger, sandwich]
	rng.randomize()
	var my_random_number = rng.randf_range(0, 2)
	var name = image_players[my_random_number]
	$Sprite.texture = (name)

func _physics_process(delta):
	
	match state:
		IDLE:
			idle_state()
		LAUNCH:
			launch_state(delta)
			fruit_velocity.y += fruit_gravity*delta
			
	var collide =move_and_collide(fruit_velocity * delta)
	if collide and aimming == false:
		var temp  =collide.collider
#		print(collide.collider_shape)
#		print(collide.position)
#
#		var tile=get_parent().get_node("TileMap")
#		print(tile.world_to_map(collide.position))
		teleport()

func launch_state(delta):
	
	var target_pos = get_viewport().get_mouse_position()
	#print(target_pos)
#	var arc_height = target_pos.y - position.y -64
#	arc_height = min(arc_height, -64)
#	fruit_velocity = calculate_arc_velocity(position,target_pos, arc_height)
	
	#time += 0.01
#	if time< up_time:
#		position += fruit_velocity* time
#	fruit_velocity += Vector2(0,.009)*time
#	position += fruit_velocity*time +.5*Vector2(0,.009)*time*time


func idle_state():
	#if chef.direction.x <= 0:
	position = chef.position - Vector2(0,15)
	#else:
	#position = chef.position + Vector2(34,-20)
	
#	fruit_texture.position.x = food_position.x-50
#	fruit_texture.position.y = food_position.y+10
	var target_pos = get_viewport().get_mouse_position()
	target_pos.y = max(target_pos.y, max_height)
	target_pos.x = max(target_pos.x, position.x -600)
#	print(target_pos)
	var arc_height = target_pos.y - position.y -30
	arc_height = min(arc_height, -30)
	if aimming:
		fruit_velocity = calculate_arc_velocity(position,target_pos, arc_height,1660)
	else:
		$Line2D.clear_points()
	if Input.is_action_just_released("throw") and aimming:
#		fruit_velocity.x = -pos.direction_to(chef.position).x*2.5
#		fruit_velocity.y = -pos.direction_to(chef.position).y*2.5
		state = LAUNCH
		aimming = false
		collisionshape.disabled = false
		$Line2D.clear_points()
		

func calculate_arc_velocity(point_a, point_b, arc_height, \
			up_gravity = 1750, down_gravity = null):
		
		if down_gravity == null:
			down_gravity = up_gravity
		
		var points = PoolVector2Array()
		var point_pos = point_a
		
		var projectile_velocity = Vector2.ZERO
		var displacement = point_b - point_a
		if aimming == false:
			$Line2D.clear_points()
		
		if displacement.y > arc_height:
			var up_time = sqrt(-2*arc_height/ float(up_gravity))
			var down_time = sqrt(2* (displacement.y - arc_height) / float(down_gravity))
			
			projectile_velocity.y = -sqrt(-2*up_gravity*arc_height)
			projectile_velocity.x = displacement.x / float(up_time+down_time)
			
			for i in total_point:
				time = (up_time+down_time)*i / total_point
				var dx = projectile_velocity.x * time
				var dy = (projectile_velocity.y * time + .5 * (up_gravity+800) * time *time)
				#point_pos += projectile_velocity.y*time + .5*down_gravity*time*time
				
				points.append(Vector2(dx,dy))
#				if state !=  1:
#					update()
			$Line2D.points = points
		
		return projectile_velocity


func teleport():
	#chef_particle.position = chef.global_position
	chef.reverse_position = chef.position
	chef_particle.emitting = true
	
	
	chef.position = position - Vector2(0,30)
	chef.teleported_pos = chef.position
	print(chef.teleported_pos)
	
	queue_free()
	
func reverse_teleport():
	chef.position = reverse_position
	#chef.position = Vector2(50, 250)

func in_water():
	gravity = -gravity / 3
	max_speed = max_speed_in_water
#var white = Color(1,1,1,1)
#
#
#func _draw():
#	for i in range(0, points.size() - 1):
#		draw_circle(points[i], 1, white)


func _on_Area2D_body_entered(body):
	print(body.name)
#	if body.name == "moving_platform":
#		reverse_teleport()
