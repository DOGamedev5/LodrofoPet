extends State


func enter(_ls):
	
	if not parent.running:
		$"../../AnimationPlayer".play("jump")
		parent.direction.x = 1 - ((randi() % 2) * 2)

	
	var movement : Vector2 = Vector2.DOWN * parent.jump_force * rand_range(0.3, 1.2)
	parent.motion.y = movement.y

	$Timer.start()

func process_state():
		
	if parent.motion.y >= 0:
		return "FALL"
