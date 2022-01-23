extends KinematicBody2D

var move = Vector2()
var speed = 300


func _physics_process(delta):

	get_input()
	move = move_and_slide(move)



func get_input():
	
	move = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		move.x += speed
		
	if Input.is_action_pressed("ui_left"):
		move.x -= speed
		
	if Input.is_action_pressed("ui_down"):
		move.y += speed
		
	if Input.is_action_pressed("ui_up"):
		move.y -= speed
	
	move = move.normalized() * speed
	
