extends KinematicBody2D

class_name NormalNote

var _velocity: Vector2 = Vector2.ZERO
var _speed: Vector2 = Vector2(10.0, 0.0)

# INTERNALS

func _physics_process(delta: float) -> void:
	
	var collision: KinematicCollision2D = move_and_collide(_velocity, true)
	
	_velocity.x = _speed.x * delta
	
	if collision:
		$CollisionShape2D.disabled = true
		queue_free()

# METHODS

func calculate_shoot_origin_global_position(
		direction: String,
		shoot_origin_global_position: Vector2
	) -> void:

	if direction == "left":
			_speed.x *= -1

	global_position = shoot_origin_global_position
