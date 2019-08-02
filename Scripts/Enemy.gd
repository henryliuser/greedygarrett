extends KinematicBody2D

onready var parent = get_parent()
var playerInRange = false
export var health = 1
onready var target = $target

func isEnemy():
	pass

func move():
	var direction = (target.global_position - global_position).normalized()
	parent.move_and_slide(direction)
	if !playerInRange:
		if abs(target.global_position.x - global_position.x) < 10 and abs(target.global_position.y - global_position.y) < 10:
			target.global_position = Vector2(randi()%1600, randi()%900)
		

func getHurt(body):
	if body.has_method("isProjectile"):
		if body.damage > 0:
			health -= body.damage

func _process(delta):
	move()


func _on_hitbox_body_entered(body):
	getHurt(body)


func _on_hitbox_body_exited(body):
	pass # Replace with function body.


func _on_playerDetector_body_entered(body):
	if body.has_method("isPlayer"):
		playerInRange = true
		target = body


func _on_playerDetector_body_exited(body):
	if body.has_method("isPlayer"):
		playerInRange = false
		target = $target