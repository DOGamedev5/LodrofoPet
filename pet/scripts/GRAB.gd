extends State

func enter(_ls):
	$"../../AnimationPlayer".play("jump")
	parent.direction = Vector2.ZERO

func physics_process(_delta):
	
	pass

func process_state():
	if not parent.is_grabbed:
		return "FALL"
	pass

func exit():
	parent.motion = parent.velocity * 10
