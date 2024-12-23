extends State

onready var time := $Timer
export var runningSpeed := 500

var nextState := ["IDLE", "JUMP", "IDLE", "IDLE", "JUMP", "JUMP", "WALK"]

func enter(ls):
	parent.running = true
	parent.max_speed = parent.run_speed
	
	$"../../AnimationPlayer".play("run")
	
	if ls != "WALK":
		parent.direction.x = 1 - ((randi() % 2) * 2)
		if abs(parent.motion.x) <= parent.run_speed * 0.2:
			parent.motion.x = parent.run_speed * 0.2 * parent.direction.x

	time.wait_time = rand_range(3, 5)
	time.start()

func process_state():
	if not parent.onFloor():
		return "FALL"
		
	if time.is_stopped():
		nextState.shuffle()
		return nextState[0]


