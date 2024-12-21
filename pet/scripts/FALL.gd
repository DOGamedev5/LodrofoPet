extends State


func enter(_ls):
	$"../../AnimationPlayer".play("fall")

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
	
	if OS.window_position.y < 0:
		parent.motion.y = 0
		parent.window_position_delta.y = 0
		
		parent.motion.x /= 2
	
func process_state():
	if parent.onFloor():
		return "IDLE"

