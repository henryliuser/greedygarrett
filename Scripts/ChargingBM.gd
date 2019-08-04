extends KinematicBody2D

var speed = 200

func calculateRotation():
	var playerPos = get_parent().get_parent().get_node("Player").global_position
	var dx = playerPos.x - position.x
	var dy = playerPos.y - position.y
	var thetaRad = atan2(dy,dx) + PI/2
	var currRad = rotation_degrees*PI/180

	rotation_degrees = Global.lerp_angle(currRad,thetaRad,0.5) * 180/PI
	var thetaDeg = thetaRad/PI*180
	if abs(rotation_degrees-thetaDeg) <= 1:
		rotation_degrees = thetaDeg

func _physics_process(delta):
	calculateRotation()