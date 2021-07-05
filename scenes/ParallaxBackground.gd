extends ParallaxBackground

export (float) var speed = 500

func _process(delta):
	scroll_offset.y += speed*delta
	
