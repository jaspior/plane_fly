extends TouchScreenButton

var radius = Vector2(64,64)
var limite = 48
var going_drag = -1
export var return_accel = 20
var threshold = 5


func _process(delta):
	if going_drag == -1:
		var pos_difference = (Vector2.ZERO - radius) - position
		position += pos_difference * return_accel * delta

func get_button_pos():
	return position + radius



func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_distance_from_center = (event.position - get_parent().global_position).length()

		if event_distance_from_center <= limite * global_scale.x or event.get_index() == going_drag:
			set_global_position(event.position - radius * global_scale) 
		
			#voltar ao Centro
			if get_button_pos().length() > limite:
				set_position(get_button_pos().normalized() * limite - radius)
			going_drag = event.get_index()
			
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == going_drag:
		######################################
		#controle de quando solta o joystick#
		######################################
		going_drag = -1


func get_value():
	######################################
	# Não normalizado                    #
	######################################
	if get_button_pos().length() > 10:
		return get_button_pos().normalized()
		
	######################################
	# Normalizado      ###################
	######################################	
#	if get_button_pos().length() > threshold:
#		return get_button_pos().normalized()
#	if get_button_pos().length() > 10 and get_button_pos().length() < 80:
#		return get_button_pos().normalized() * 0.5
#	elif get_button_pos().length() > 80:	
#		return get_button_pos().normalized()
