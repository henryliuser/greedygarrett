extends KinematicBody2D

var hp = 100
var money = 0
var velocity = Vector2()
var movementSpeed = 1000

func isPlayer(): #ignore this
	pass		#but it's important, henry

func _physics_process(delta):
	calculateMovement()
	calculateRotation()
	
func calculateMovement():
	var movement = Vector2()
	
	var up = Input.is_action_pressed("up")
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	var down = Input.is_action_pressed("down")
	
	if left and not right:
		movement.x = -1
	elif right and not left:
		movement.x = 1
	if up and not down:
		movement.y = -1
	elif down and not up:
		movement.y = 1
	
	var temp = movement * movementSpeed
	temp = lerp(velocity, temp, 0.4)
	move_and_slide(temp)
	
func calculateRotation():
	var mousePos = get_viewport().get_mouse_position()
	var dx = mousePos.x - position.x
	var dy = mousePos.y - position.y
	var thetaRad = atan2(dy,dx) + PI/2
	var currRad = rotation_degrees*PI/180

	rotation_degrees = Global.lerp_angle(currRad,thetaRad,0.5) * 180/PI
	var thetaDeg = thetaRad/PI*180
	if abs(rotation_degrees-thetaDeg) <= 1:
		rotation_degrees = thetaDeg
	
func getHit(dmg):
	hp -= dmg
	if hp <= 0:
		Global.gameOver()
	
	
	
func getMoney(denom):
	money += denom
	while money > 99:
		money -= 100
		hp -= 5