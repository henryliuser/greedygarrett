extends Area2D
var velocity = Vector2()
var damage = 15
var lifespan = 10
var counter = 0

func isProjectile():
	pass
	
func _physics_process(delta):
	position += velocity * delta
	counter += 1
	if counter >= lifespan:
		queue_free()

