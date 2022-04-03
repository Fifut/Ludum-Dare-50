extends Node


signal start_game
signal end_game


onready var Score = $CanvasLayer/Control/VBoxContainer/Score


var _score:= 0


func _ready():
	Score.visible = false
	
	# Connect self to start and end game signals
	connect("start_game", self, "_startGame" )
	connect("end_game", self, "_endGame" )


func _process(delta):
	Score.text = "Score  " + str(_score)


func getScore():
	return _score


func _startGame():
	_score = 0
	Score.visible = true
	$TimerScore.start()


func _endGame():
		Score.visible = false
		$TimerScore.stop()


func _on_TimerScore_timeout():
	_score += 1
