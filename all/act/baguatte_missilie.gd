extends Area2D

export var speed = 350
export var steer_force = 50.0

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null
onready var particle:= $Particles2D

func start(_transform, _target):
	global_transform = _transform
	rotation += rand_range(-0.09, 0.09)
	velocity = transform.x * speed
	target = _target

func seek()->Vector2:
	var steer = Vector2.ZERO
	if target:
		var desired = (target - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func _physics_process(delta):
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	rotation = velocity.angle()
	position += velocity * delta
	if Input.get_action_strength("aim"):
		particle.emitting = true
		target = get_parent().get_node("Chef").position
#func _on_Missile_body_entered(body):
	

#func _on_Lifetime_timeout():
	

func explode():
	$Particles2D.emitting = false
	set_physics_process(false)
	#$AnimationPlayer.play("explode")
	#yield($AnimationPlayer, "animation_finished")
	queue_free()


func _on_Timer_timeout():
	explode()# Replace with function body.


func _on_baguatte_missilie_body_entered(body):
	explode()
