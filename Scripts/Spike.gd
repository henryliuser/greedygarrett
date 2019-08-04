extends Sprite
var damage = 1
var playerInRange = false
var player = null
var counter = 9

func _on_Area2D_body_entered(body):
	if body.has_method("isPlayer"):
		playerInRange = true
		player = body

func _on_Area2D_body_exited(body):
	if body.has_method("isPlayer"):
		playerInRange = false
		player = null

func hurtPlayer():
	if playerInRange:
		counter += 1
		if counter >= 10:
			player.getHit(damage, Vector2())
			counter = 0
	else:
		counter = 9

func _process(delta):
	hurtPlayer()
