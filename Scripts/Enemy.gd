extends KinematicBody2D

onready var parent = get_parent()
var playerInRange = false
export var health = 100
onready var target = $target
var targetPos

func _ready():
	target.global_position = Vector2(randi()%1600, randi()%900)
	targetPos = target.global_position

func isEnemy():
	pass

func move():
	if playerInRange:
		var direction = (target.global_position - global_position).normalized()
		parent.move_and_slide(direction * parent.speed)
	else:
		var direction = (targetPos - global_position).normalized()
		parent.move_and_slide(direction * parent.speed)
		if abs(targetPos.x - global_position.x) < 50 and abs(targetPos.y - global_position.y) < 50:
			target.global_position = Vector2(randi()%1600, randi()%900)
			targetPos = target.global_position
		


func _process(delta):
	move()


func _on_hitbox_area_entered(body):
	print("suh")
	if body.has_method("isProjectile"):
		if body.damage > 0:
			health -= body.damage
			if health <= 0:
				parent.queue_free()
		parent.move_and_slide(body.velocity*0.5)
		body.queue_free()


func _on_hitbox_body_exited(body):
	pass # Replace with function body.


func _on_playerDetector_body_entered(body):
	if body.has_method("isPlayer"):
		playerInRange = true
		target = body
		#get_node("playerDetector/CollisionShape2D").shape.radius = 300 breaks the code


func _on_playerDetector_body_exited(body):
	if body.has_method("isPlayer"):
		playerInRange = false
		target = $target
		target.global_position = Vector2(randi()%1600, randi()%900)
		targetPos = target.global_position
		#get_node("playerDetector/CollisionShape2D").shape.radius = 200 breaks the code