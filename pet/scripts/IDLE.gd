extends State

onready var time := $Timer

var nextState := ["WALK", "JUMP", "WALK", "WALK", "WALK"]

func enter(_ls):
	parent.modulate = Color(1, 0.3, 0.6)
	parent.direction.x = 0
	time.wait_time = rand_range(2, 5)
	time.start()

func process_physics(_delta):
	if OS.window_position.x < 0:
		if parent.motion.x < 0:
			parent.motion.x *= -parent.bounce
			
		parent.window_position_delta.x = 0
		parent.motion.y /= 2
		
	if OS.window_position.x + OS.window_size.x > OS.get_screen_size().x:
		if parent.motion.x > 0:
			parent.motion.x *= -parent.bounce
			
		parent.window_position_delta.x = OS.get_screen_size().x - OS.window_size.x
		parent.motion.y /= 2

func process_state():
	if not parent.onFloor():
		return "FALL"
	
	if time.is_stopped():
		nextState.shuffle()
		return nextState[0]
	
	
