extends Node2D

var direction := Vector2.ZERO
export var velocity := 120
export var have_gravity := true
export var gravity_force := 400
var window_position_delta := Vector2.ZERO
var is_grabbed := false

func _ready():
	window_position_delta = OS.window_position
	randomize()
	$StateMachine.init(self)

func _physics_process(delta):
	$StateMachine.processMachine(delta)
	if not is_grabbed:
		move(delta)
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				is_grabbed = true
				$StateMachine.changeState("GRAB")
			else:
				is_grabbed = false
	
	if event is InputEventMouse:
		print(event.position)
	
	if event is InputEventMouse and is_grabbed:
		
		OS.window_position = OS.window_position+(event.position-(OS.window_size/2)) 
		window_position_delta = OS.window_position

func move(delta):
	if window_position_delta.x < 0 and direction.x < 0:
		window_position_delta.x = 0
		direction.x = 1
	
	if window_position_delta.x > OS.get_screen_size().x - (OS.window_size.x) and direction.x > 0:
		window_position_delta.x = OS.get_screen_size().x - (OS.window_size.x)
		direction.x = -1
	
	var movement : Vector2 = direction * delta * velocity
	
	window_position_delta += movement
	
	if have_gravity:
		gravity(delta)
		
	if window_position_delta.y > OS.get_screen_size().y - (OS.window_size.y):
		window_position_delta.y = OS.get_screen_size().y - (OS.window_size.y)
	
	OS.window_position = window_position_delta



func gravity(delta):
	if not onFloor(): return
	
	var movement : Vector2 = Vector2.DOWN * gravity_force * delta
	
	window_position_delta += movement

func onFloor():
	return OS.window_position.y < OS.get_screen_size().y - (OS.window_size.y)


func _on_Timer2_timeout():
	pass
