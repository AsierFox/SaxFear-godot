extends Node

class_name PlayerEventManager

func _ready() -> void:
	pass

# SIGNALS

func _on_Player_player_shoot(note_type, direction, shoot_origin_global_position) -> void:
	var note = note_type.instance()
	note.calculate_shoot_origin_global_position(direction, shoot_origin_global_position)
	add_child(note)
