extends State


func enter(_ls):
	pass

func _physics_process(_delta):
	
	
	pass

func process_state():
	if parent.onFloor():
		return "IDLE"
