extends Area2D


var _body = null

export var name_ = "none"
export var power = 10
export var health = 5


func _ready():
	$Health.visible = false


func _process(delta):
	
	# Si player présent et touche entrer
	if _body != null and Input.is_action_just_pressed("ui_accept"):
		
		# Si inventaire joueur vide
		if _body.isEmpty():
			
			# Vie objet -1
			health -= 1
			$Health.visible = true
			$Health.text = str(health)
			print("Pickable " + name_ + ": health " + str(health) )
			
			# Son "hurt"
			$AudioStreamPlayer.play()
			yield($AudioStreamPlayer, "finished")

			# Si vie objet = 0, donne au joueur
			if health < 1:
				_body.setItem(name_, power)
				print("Pickable " + name_ + ": picked")
				queue_free()



func _on_body_entered(body):
	print("Pickable " + name_ + " body entered")
	_body = body

func _on_body_exited(body):
	print("Pickable " + name_ + " body exited")
	_body = null
