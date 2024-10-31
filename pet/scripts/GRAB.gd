extends State

func enter(_ls):
	parent.direction = Vector2.ZERO

func _physics_process(_delta):
	
	pass

func process_state():
	if not parent.is_grabbed:
		return "IDLE"
	pass
