extends Area2D


var _body = null
export var item_name = "none"


func _process(delta):
	
	if _body != null and Input.is_action_just_pressed("ui_accept"):
		print("Pickable " + item_name + ": picked")
		$AudioStreamPlayer.play()
		yield($AudioStreamPlayer, "finished")
		_body.setItem(item_name)
		queue_free()



func _on_body_entered(body):
	print("Pickable " + item_name + " body entered")
	_body = body

func _on_body_exited(body):
	print("Pickable " + item_name + " body exited")
	_body = null
