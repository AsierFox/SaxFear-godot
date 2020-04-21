extends Entity

class_name Player

signal player_shoot(note_type, direction, location)

var _can_shoot: bool = true
var _shoot_cadence: float = 1
var _shoot_cadence_counter: float = 0.0

# TODO Make a enum for this
var current_animation_direction: String = "right"

var NormalNote = preload('res://src/Nodes/NormalNote.tscn')

# SIGNALS

func _shoot() -> void:
	_can_shoot = false
	
	emit_signal('player_shoot', NormalNote,
		current_animation_direction, $ShootOrigin.global_position)

# INTERNALS

func _physics_process(delta: float) -> void:
	_update_shoot_cadence(delta)

	_input_process()

	var is_jump_interrupted: bool = Input.is_action_just_released("player_jump") and _velocity.y < 0.0

	var direction: Vector2 = _get_input_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	# Translate top to normal Vector2(0, -1)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

	_update_animation(direction)

# METHODS

func _input_process() -> void:

	if _can_shoot and Input.is_key_pressed(KEY_SPACE):
		_shoot()

func _get_input_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("player_right") - Input.get_action_strength("player_left"),
		-1.0 if Input.is_action_just_pressed("player_jump") and  is_on_floor() else 1.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:

	var new_velocity: Vector2 = linear_velocity

	new_velocity.x = speed.x * direction.x
	new_velocity.y += GRAVITY * get_physics_process_delta_time()

	if direction.y < 0.0:
		new_velocity.y = speed.y * direction.y

	if is_jump_interrupted:
		new_velocity.y = 0.0

	return new_velocity

func _update_animation(direction: Vector2) -> void:

	if direction.x > 0.0:
		if current_animation_direction == "left":
			current_animation_direction = "right"
			$Sprite.set_flip_h(false)
			$ShootOrigin.position.x *= -1

	elif direction.x < 0.0:
		if current_animation_direction == "right":
			current_animation_direction = "left"
			$Sprite.set_flip_h(true)
			$ShootOrigin.position.x *= -1

func _update_shoot_cadence(delta: float) -> void:
	if !_can_shoot:
		_shoot_cadence_counter += delta

		if _shoot_cadence_counter >= _shoot_cadence:
			_can_shoot = true
			_shoot_cadence_counter = 0.0
