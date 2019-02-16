extends KinematicBody2D

var velocity : Vector2 = Vector2.ZERO
var speed : float = 60.0

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	velocity.x = speed * delta
	
	var collision : KinematicCollision2D = move_and_collide(velocity)
	
	if collision:
		print(collision)
		free()
