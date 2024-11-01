extends State

func enter(_ls):
	parent.modulate = Color(0.7, 0.6, 0.2)
	parent.direction = Vector2.ZERO

func physics_process(_delta):
	
	pass

func process_state():
	if not parent.is_grabbed:
		return "FALL"
	pass

func exit():
	parent.motion = parent.velocity * 10
