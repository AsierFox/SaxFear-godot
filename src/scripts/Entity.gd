extends KinematicBody2D

class_name Entity

const GRAVITY: float = 700.0
const FLOOR_NORMAL: Vector2 = Vector2.UP

# Pixels per second
var speed: Vector2 = Vector2(140, 320)
var _velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass
