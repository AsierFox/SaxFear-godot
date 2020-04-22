extends Entity

class_name BasicEnemy

func _ready() -> void:
	set_physics_process(false)
	
	_velocity.x = -speed.x

# SIGNALS

func _on_enemy_top_area_entered(body: Node) -> void:
	if body.global_position.y > $TopArea2D.global_position.y:
		return
	$TopArea2D/CollisionShape2D.disabled = true
	queue_free()

# INTERNALS

func _physics_process(delta: float) -> void:
	_velocity.y += GRAVITY * delta

	var snap: Vector2 = Vector2.DOWN * 80.0

	_velocity.y = move_and_slide_with_snap(_velocity, snap, FLOOR_NORMAL, true, 4, PI / 3).y

	if is_on_wall():
		_velocity.x *= -1.0
