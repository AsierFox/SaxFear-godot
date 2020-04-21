extends Entity

class_name BasicEnemy

func _ready() -> void:
	set_physics_process(false)
	
	_velocity.x = -speed.x

# SIGNALS

func _on_enemy_top_area_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > $Area2D.global_position.y:
		return
	$Area2D/CollisionShape2D.disabled = true
	queue_free()

# INTERNALS

func _physics_process(delta: float) -> void:
	_velocity.y += GRAVITY * delta

	if is_on_wall():
		_velocity.x *= -1.0

	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
