extends State

onready var time := $Timer

func enter(_ls):
	parent.direction.x = 1 - ((randi() % 2) * 2)


	time.wait_time = rand_range(0.5, 12)
	time.start()

func _physics_process(_delta):
	
	pass

func process_state():
	if time.is_stopped():
		return "IDLE"
	
