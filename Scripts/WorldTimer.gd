extends Node

export(int) var hour = 6
export(int) var minutes = 0

func _ready():
	$Timer.connect('timeout', self, '_on_Timer_timeout')
	
	$TimerLabel.text = 'MEW'

func _on_Timer_timeout():
	print('One second passed by')
	
