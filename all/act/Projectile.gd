extends Node2D
class_name Projectile
#
#var points = PoolVector2Array()
#onready var fruit = get_node("../../Fruits")
#func _process(delta):
#	var pos = get_viewport().get_mouse_position()
#	var position = fruit.fruit_texture.position;
#	var velocity = -pos.direction_to(position)*2.5
#	var gravity = Vector2(0, .009)
#
#	points = PoolVector2Array()
#	var time = 0.0
#	for i in range(200):
#		time += .75
#		points.append(position)
#		velocity += gravity*time
#		position += velocity*time + .5*gravity*time*time
#	if fruit.state !=  1:
#		update()
#
#var white = Color(1,1,1,1)
#
#
#func _draw():
#	for i in range(0, points.size() - 1):
#		draw_circle(points[i], 1, white)


#static func calculate_arc_velocity(point_a, point_b, arc_height, state, \
#			up_gravity = -40, down_gravity = null):
#		if down_gravity == null:
#			down_gravity = up_gravity
#
#		var points = PoolVector2Array()
#		var point_pos = point_a
#	#	var time = 0.0
#
#	#
#		#var white = Color(1,1,1,1)
#		#
#		#
#		#func _draw():
#		#	for i in range(0, points.size() - 1):
#		#		draw_circle(points[i], 1, white)
#
#
#
#		var projectile_velocity = Vector2.ZERO
#		var displacement = point_b - point_a
#
#		if displacement.y > arc_height:
#			var up_time = sqrt(-2*arc_height/ float(up_gravity))
#			var down_time = sqrt(2* (displacement.y - arc_height) / float(down_gravity))
#
#			projectile_velocity.y = -sqrt(-2*up_gravity*arc_height)
#			projectile_velocity.x = displacement.x / float(up_time+down_time)
#
#			for i in range(down_time):
#		#		time += .75
#				points.append(point_pos)
#		#		velocity += gravity*time
#		#		position += velocity*time + .5*gravity*time*time
#				if state !=  1:
#					update()
#
#
#
#		return projectile_velocity




