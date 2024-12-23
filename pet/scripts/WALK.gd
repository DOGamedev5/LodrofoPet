extends State

onready var time := $Timer

var nextState := ["IDLE", "JUMP", "IDLE", "IDLE", "JUMP", "WALK", "RUN", "RUN", "RUN"]

func enter(_ls):
	parent.running = false
	parent.max_speed = parent.normalSpeed
	$"../../AnimationPlayer".play("walk")

	parent.direction.x = 1 - ((randi() % 2) * 2)

	time.wait_time = rand_range(0.5, 12)
	time.start()

func process_state():
	if not parent.onFloor():
		return "FALL"
		
	if time.is_stopped():
		nextState.shuffle()
		return nextState[0]
	
