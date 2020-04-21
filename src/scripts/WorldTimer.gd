extends Node

export(int) var hour: int = 6
export(int) var minutes: int = 0

func _ready() -> void:
	$Timer.connect('timeout', self, '_on_Timer_timeout')

	$CanvasLayer/TimerLabel.text = String('MEW')

# SIGNALS

func _on_Timer_timeout() -> void:
	print('One second passed by')
