extends Area2D

onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass

# SIGNALS

func _on_Node2D_body_entered(body) -> void:
	animation_player.play("fade_out")
