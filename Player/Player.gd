extends KinematicBody2D


const FLOOR_NORMAL: = Vector2.UP


export var speed: = Vector2(200.0, 200.0)
export var gravity: = 1000.0


onready var Inventory = $CanvasLayer/Control/VBoxContainer/Inventory


var _velocity: = Vector2.ZERO
var _item: = "none"
var _power: = 0


func _process(delta):
	if _item != "none":
		Inventory.text = "Inventory : " + _item
	else:
		Inventory.text = ""


func _physics_process(delta: float) -> void:
	
	# Gravity
	_velocity.y += gravity * delta
	
	# Regarde si on arrête le saut
	var is_jump_interrupted: = Input.is_action_just_released("ui_up") and _velocity.y < 0.0
	
	# Get player direction
	var direction: = get_direction()
	
	if direction.x < 0:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	elif direction.x > 0:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
	elif Input.is_action_just_pressed("ui_accept"):
		$AnimatedSprite.play("hit")
		yield($AnimatedSprite, "animation_finished")
	else:
		$AnimatedSprite.play("stand")
	
	# Compute velocity
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	


# Input joueur pour la direction
func get_direction() -> Vector2:
	
	var out: Vector2
	
	# Gauche droite
	out.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	# Saut
	#if is_on_floor() and Input.is_action_just_pressed("ui_up"):
	#	out.y = -Input.get_action_strength("ui_up")
	#else:
	#	out.y = 0.0
	
	return out



# Calcul nouvelle vitesse en x et y
func calculate_move_velocity(actual_velocity: Vector2, direction: Vector2, speed: Vector2, is_jump_interrupted: bool) -> Vector2:
	
	var out: = actual_velocity
	
	# Déplacement gauche droite
	out.x = speed.x * direction.x
	
	# Saut (si pas au sol)
	if direction.y != 0.0:
		out.y = speed.y * direction.y
	
	# Si le saut à été interrompu
	if is_jump_interrupted:
		out.y = 0.0
		
	return out
	
	
	
func isEmpty() -> bool:
	if _item == "none":
		return true
	else:
		return false



func setItem(item: String, power: int) -> bool:
	if _item == "none":
		_item = item
		_power = power
		return true
	else:
		return false


func getItem():
	
	if _item != "none":
		var r_item = _item
		var r_power = _power
		_item = "none"
		_power = 0
		return [r_item, r_power]
		
	else:
		return ["none", 0]
