extends KinematicBody2D

var move = Vector2()
var speed = 300
var can_shot = false

func _ready():
	
	GameSingleton.connect("levelUP",self,"level_UP")
	
	
func _physics_process(delta):
	get_input()
	move = move_and_slide(move)
	
	
func level_UP():
	
	match GameSingleton.level_player:
		1:
			set_scalePlayer()
			print("LEVEL 1")
		2: 
			set_scalePlayer()
			print("LEVEL 2")
		3:
			set_scalePlayer()
			print("LEVEL 3")




func set_scalePlayer():
	
	for i in 50:
		yield(get_tree().create_timer(0.01),"timeout")
		scale.x += 0.02
		scale.y += 0.02
	yield(get_tree().create_timer(1),"timeout")
	
	for i in 50:
		yield(get_tree().create_timer(0.01),"timeout")
		$Camera2D.zoom.x += 0.01
		$Camera2D.zoom.y += 0.01
		
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
	
