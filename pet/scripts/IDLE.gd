extends State

onready var time := $Timer

func enter(_ls):
	parent.direction.x = 0
	time.wait_time = rand_range(2, 5)
	time.start()

func process_state():
	if time.is_stopped():
		return "WALK"
	
