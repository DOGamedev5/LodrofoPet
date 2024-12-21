extends Node2D

onready var sprite := $Icon
onready var normalSpeed := 200

export var max_speed := 120
export var run_speed := 400
export var acceleration := 50
export var have_gravity := true
export var gravity_force := 200
export var jump_force := -400
export var friction_force := 3.8
export var bounce := 0.5
export var canFlipH := false
export var canFlipV := false

var motion := Vector2.ZERO
var direction := Vector2.ZERO
var window_position_delta := Vector2.ZERO
var is_grabbed := false

var last_positions := []
var velocity := Vector2.ZERO
var running := false

func _ready():
	normalSpeed = max_speed
	window_position_delta = OS.window_position
	randomize()
	$StateMachine.init(self)

func _physics_process(delta):
	$StateMachine.processMachine(delta)
	if not is_grabbed:
		moveMotion(delta)
		move(delta)
		if OS.window_position.y < 0:
			motion.y = 0

		if canFlipH and motion.x:
			sprite.flip_h = motion.x < 0
		
		if canFlipV and motion.y:
			sprite.flip_v = motion.y < 0
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				is_grabbed = true
				$StateMachine.changeState("GRAB")
			else:
				is_grabbed = false
	
	if event is InputEventMouse and is_grabbed:
		
		OS.window_position = OS.window_position+(event.position-(OS.window_size/2)) 
		window_position_delta = OS.window_position

func move(delta):
	if window_position_delta.x <= 0 and direction.x < 0:
		window_position_delta.x = 0
		direction.x = 1
		motion.x *= -1
	
	if window_position_delta.x >= OS.get_screen_size().x - (OS.window_size.x) and direction.x > 0:
		window_position_delta.x = OS.get_screen_size().x - (OS.window_size.x)
		direction.x = -1
		motion.x *= -1
	
	var movement : Vector2 = motion * delta
	
	window_position_delta += movement
	
	if have_gravity:
		gravity(delta)
		
	if window_position_delta.y > OS.get_screen_size().y - (OS.window_size.y):
		window_position_delta.y = OS.get_screen_size().y - (OS.window_size.y)
	
	OS.window_position = window_position_delta

func moveMotion(delta):
	
	if direction.x > 0 and motion.x < max_speed:
		motion.x += acceleration * delta
		if motion.x > max_speed:
			motion.x = max_speed
			
	if direction.x < 0 and motion.x > -max_speed:
		motion.x -= acceleration * delta
		if motion.x < -max_speed:
			motion.x = -max_speed
	
	if not direction.x and onFloor():
		var lastDirection := sign(motion.x)
		motion.x -= friction_force * motion.x * delta
		if lastDirection != sign(motion.x):
			motion.x = 0


func gravity(delta):
	if onFloor():
		if motion.y > 0:
			motion.y = 0
		return
	
	var movement : Vector2 = Vector2.DOWN * gravity_force * delta
	
	motion += movement

func onFloor():
	return OS.window_position.y >= OS.get_screen_size().y - (OS.window_size.y)

func _on_Timer_timeout():
	last_positions.append(OS.window_position)
	if last_positions.size() > 2:
		last_positions.pop_front()
		velocity = last_positions[1] - last_positions[0]
