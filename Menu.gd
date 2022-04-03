extends Control


onready var Score = $Score


func _process(delta):
	# Display score
	Score.text = "Score " + str(Engine.getScore() )


func _on_Start_button_up():
	# Tell to engine to start game
	Engine.emit_signal("start_game")
