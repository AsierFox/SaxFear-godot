extends Node

func _ready():
	$'../Player'.connect('shoot', self, '_on_Player_shoot')

func _on_Player_shoot(note_type, direction, location):
	var note = note_type.instance()
	if direction == "left":
		note.speed *= -1
	note.position = location
	add_child(note)
