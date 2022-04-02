extends Node


signal start_game
signal end_game


var _temperature:= 0
var _fire_status:= true
var _score:= 0



func _ready():
	$CanvasLayer/HUD/Control/VBoxContainer/Temperature.visible = false
	$CanvasLayer/HUD/Control/VBoxContainer/Score.visible = false
	connect("start_game", self, "_startGame" )
	connect("end_game", self, "_endGame" )


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/HUD/Control/VBoxContainer/Temperature.text = "Temperature " + str(_temperature)
	$CanvasLayer/HUD/Control/VBoxContainer/Score.text = "Score  " + str(_score)
	

	if _temperature < 15:
		$CanvasLayer/HUD/Control/VBoxContainer/Temperature.modulate = "#ff0000"
	elif _temperature < 20:
		$CanvasLayer/HUD/Control/VBoxContainer/Temperature.modulate = "#0000ff"
	elif _temperature >= 20:
		$CanvasLayer/HUD/Control/VBoxContainer/Temperature.modulate = "#00ff00"



func setFire(status: bool):
	if status:
		$CanvasLayer/HUD/Timer.stop()
		$CanvasLayer/HUD/Timer.start()
		_fire_status = true
	else:
		$CanvasLayer/HUD/Timer.stop()
		$CanvasLayer/HUD/Timer.start()
		_fire_status = false


func getScore():
	return _score


func getTemperature():
	return _temperature
	

func _startGame():
		_temperature = 20
		_score = 0
		$CanvasLayer/HUD/Control/VBoxContainer/Temperature.visible = true
		$CanvasLayer/HUD/Control/VBoxContainer/Score.visible = true
		$TimerScore.start()


func _endGame():
		$CanvasLayer/HUD/Control/VBoxContainer/Temperature.visible = false
		$CanvasLayer/HUD/Control/VBoxContainer/Score.visible = false
		$TimerScore.stop()



func _on_Timer_timeout():
	
	if _fire_status and _temperature < 25:
		$CanvasLayer/HUD/Control/VBoxContainer/Temperature.modulate = "#00ff00"
		_temperature += 1
	elif not _fire_status:
		$CanvasLayer/HUD/Control/VBoxContainer/Temperature.modulate = "#ff0000"
		_temperature -= 1


func _on_TimerScore_timeout():
	_score += 1

