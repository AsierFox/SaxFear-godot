tool
extends Area2D

onready var animation_player: AnimationPlayer = $AnimationPlayer

export(PackedScene) var next_scene: PackedScene

func _ready():
	pass

# SIGNALS

func _on_Area2D_body_entered(body: Node) -> void:
	teleport()

# INTERNALS

func _get_configuration_warning() -> String:
	if not next_scene:
		return "The next scene property next_scene can't be null"
	return ""

# METHODS

func teleport() -> void:
	animation_player.play('screen_fade_in')
	yield(animation_player, 'animation_finished')
	get_tree().change_scene_to(next_scene)
