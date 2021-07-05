extends KinematicBody2D

var speed = 500
var move = Vector2.ZERO
onready var joystick = get_tree().get_root().find_node("analogic", true, false) 
var laser = preload("res://scenes/Laser.tscn")


func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		laser()	
	
	limita()
	animation()
	move(delta)
	move_and_slide(move*speed)


func move(delta):
	move.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	if joystick.get_value() != null:
		move = joystick.get_value()
		
	move = move*delta	
	
	move = move.normalized()
	
	
	
##aqui dá pra resolver com paredes de colisão, mas vamos observar
func limita():
	if position.x <= 50:
		position.x = 50
	if position.x >= get_viewport_rect().size.x - 50:
		position.x = get_viewport_rect().size.x - 50	
	if position.y <= 50:
		position.y = 50
	if position.y >= get_viewport_rect().size.y - 50:
		position.y = get_viewport_rect().size.y - 50	


func animation():
	if move.x < 0:
		$Animation.play("right")
	elif move.x > 0:
		$Animation.play("left")
	else:
		$Animation.play("idle")

func laser():
		var shoot = laser.instance()
		get_tree().get_root().add_child(shoot)
		shoot.position = position
	


func _on_Shoot_pressed():
	laser()
