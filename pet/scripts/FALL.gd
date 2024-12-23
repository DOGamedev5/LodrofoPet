extends State

var nextState := ["IDLE", "IDLE", "IDLE", "IDLE", "IDLE", "IDLE", "WALK", "WALK", "RUN"]

func enter(_ls):
	if not parent.running:
		$"../../AnimationPlayer".play("fall")

func process_state():
	if parent.onFloor():
		nextState.shuffle()
		
		return nextState[0]

func exit():
	pass
