extends Control



func _process(delta):
	$CenterContainer/VBoxContainer/Score.text = "Score " + str(Engine.getScore() )



func _on_Start_button_up():
	Engine.emit_signal("start_game")
