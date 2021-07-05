extends Area2D

func _process(delta):
	move()

func move():
	position.y -= 10
	if position.y < 100:
		queue_free()
