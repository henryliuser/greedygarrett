extends KinematicBody2D

var speed = 300
var playerPos = Vector2()
var cooldown = 90 #in frames
var currCooldown = 0
var maxMinions = 5

func calculateRotation(playerPos):
	var dx = playerPos.x - position.x
	var dy = playerPos.y - position.y
	var thetaRad = atan2(dy,dx) + PI/2
	var currRad = rotation_degrees*PI/180

	rotation_degrees = Global.lerp_angle(currRad,thetaRad,0.5) * 180/PI
	var thetaDeg = thetaRad/PI*180
	if abs(rotation_degrees-thetaDeg) <= 1:
		rotation_degrees = thetaDeg

func shootCoin():
	currCooldown += 1
	if currCooldown >= cooldown:
		if Global.numCharging < maxMinions:
			currCooldown = 0;
			var projectileCoin = load("res://Objects/ChargingBM.tscn").instance()
			projectileCoin.global_position = global_position
			projectileCoin.get_node("Enemy").counter = 100
			get_parent().add_child(projectileCoin)
			Global.numCharging += 1

func _physics_process(delta):
	calculateRotation(playerPos)
	shootCoin()