extends State

func enter(_ls):
	pass
	
func process_state():
	if parent.onFloor():
		return "IDLE"

func exit():
	pass
