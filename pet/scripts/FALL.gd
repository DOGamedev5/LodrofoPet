extends State


func enter(_ls):
	parent.onFloor = false

	pass
	
func process_state():
	if parent.onFloor():
		return "IDLE"

func exit():
	parent.onFloor = true
