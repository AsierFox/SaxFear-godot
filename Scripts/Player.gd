extends KinematicBody2D

signal shoot(note_type, direction, location)

const GRAVITY : float = 600.0
# Pixels per second
const WALK_SPEED : int = 140
const JUMP_POWER : int = -260

var can_shoot : bool = true
var shoot_cadence : float = .8
var shoot_cadence_counter : float = 0.0

# TODO Make a enum for this
var currect_direction : String = "right"

var NormalNote = preload('res://Nodes/NormalNote.tscn')

var velocity : Vector2 = Vector2.ZERO

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	_process_input()
	
	velocity.y += GRAVITY * delta
	
	_update_shoot_cadence(delta)
	
	# Translate top to normal Vector2(0, -1)
	velocity = move_and_slide(velocity, Vector2(0, -1))

func _process_input() -> void:
	if can_shoot and Input.is_key_pressed(KEY_SPACE):
		can_shoot = false
		_shoot()
	
	if Input.is_key_pressed(KEY_A):
		velocity.x = -WALK_SPEED
		if currect_direction == "right":
			currect_direction = "left"
			$Sprite.set_flip_h(true)
			$ShootOrigin.position.x *= -1
	elif Input.is_key_pressed(KEY_D):
		velocity.x =  WALK_SPEED
		if currect_direction == "left":
			currect_direction = "right"
			$Sprite.set_flip_h(false)
			$ShootOrigin.position.x *= -1
	else:
		velocity.x = 0.0
	
	if Input.is_key_pressed(KEY_W):
		if is_on_floor():
			velocity.y = JUMP_POWER

func _shoot() -> void:
	var origin_location : Vector2 = $ShootOrigin.global_position
	emit_signal('shoot', NormalNote, currect_direction, origin_location)

func _update_shoot_cadence(delta) -> void:
	if !can_shoot:
		shoot_cadence_counter += delta
		if shoot_cadence_counter >= shoot_cadence:
			can_shoot = true
			shoot_cadence_counter = 0.0
