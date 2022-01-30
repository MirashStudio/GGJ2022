extends KinematicBody2D

var move = Vector2()
var pos_aim = Vector2()
var dist_X = 0
var dist_Y = 0
var speed = 300
var speed_aim = 10
var can_shoot = false
var delay_shoot = false
var can_move_mouse = true
var Time_delay_shoot = 1

func _ready():
	
	Input.set_custom_mouse_cursor(load("res://transparent.png"))
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	GameSingleton.connect("levelUP",self,"level_UP")
	
	
func _physics_process(delta):
	
	get_input()
	call_shoot()
	set_pos_aim()
	move_aimJoystick(delta)
	hand_look_aim()
	if can_move_mouse == false:
		get_viewport().warp_mouse($AIm.position)
	move = move_and_slide(move)
	GameSingleton.player_target = global_position
	
	
func level_UP():
	
	match GameSingleton.level_player:
		1:
			set_scalePlayer()
			AudioSystem.play_track("faixa2")
		2: 
			set_scalePlayer()
			liberate_AIM()
			speed = 400
			Time_delay_shoot = 0.6
			AudioSystem.play_track("faixa3")
			
		3:
			set_scalePlayer()
			Time_delay_shoot = 0.3
			speed = 600
			AudioSystem.play_track("faixa4")

func liberate_AIM():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	can_shoot = true
	$AIm.visible = true
	$Powerball.visible = true
	#$icon.flip_v = true
	
func hand_look_aim():
	if can_shoot == true:
		
		$icon.look_at($AIm.global_position)
	
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
	
func move_aimJoystick(delta):
	
		if Input.is_action_pressed("ui_move_aim"):
			reset_pos_aim()
			can_move_mouse = false
		if Input.is_action_pressed("aim_left") and dist_X > -50:
			dist_X -=1
			$AIm.global_position.x -= speed_aim
		if Input.is_action_pressed("aim_right")and dist_X < 50:
			dist_X += 1
			$AIm.global_position.x += speed_aim
		if Input.is_action_pressed("aim_dow") and dist_Y < 30 :
			dist_Y += 1
			$AIm.global_position.y += speed_aim
		if Input.is_action_pressed("aim_up") and dist_Y > - 30:
			dist_Y -= 1
			$AIm.global_position.y -= speed_aim
		

func reset_pos_aim():
	
	if can_move_mouse:
		$AIm.global_position = $pos_bullet.global_position
		get_viewport().warp_mouse($pos_bullet.position)
		dist_X = 0
		dist_Y = 0

func check_dist(node1, node2):
	var a=Vector2(node1 - node2 )
	return sqrt( (a.x * a.x) + (a.y * a.y) )
	
func set_pos_aim():
	
	if can_shoot == true:
		if can_move_mouse == true:
			$AIm.global_position = get_global_mouse_position()
		$pos_bullet.look_at($AIm.global_position)
		
func call_shoot():
	
	if can_shoot == true:
		if Input.is_action_just_pressed("ui_shoot"):
			can_move_mouse = true
			if delay_shoot == false:
				delay_shoot = true
				create_bullet()
				yield(get_tree().create_timer(Time_delay_shoot),"timeout")
				delay_shoot = false
				
		if Input.is_action_just_pressed("ui_shotTrigger"):
			if delay_shoot == false:
				delay_shoot = true
				create_bullet()
				yield(get_tree().create_timer(Time_delay_shoot),"timeout")
				delay_shoot = false
				
func create_bullet():
	
	var bullet = preload("res://player/bullet/bullet.tscn")
	var bl = bullet.instance()
	$pos_bullet.get_parent().add_child(bl)
	bl.update_transform($pos_bullet.transform)
