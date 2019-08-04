extends Area2D
var velocity = Vector2()
var damage = 10
var lifespan = 120
var counter = 0

func isProjectile():
	pass
	
func _physics_process(delta):
	velocity *= 1.1
	position += velocity * delta
	counter += 1
	if counter >= lifespan:
		queue_free()

func _on_BazookaProjectile_body_entered(body):
	var explosion = load("res://Objects/Explosion.tscn").instance()
	explosion.global_position = global_position
	get_parent().add_child(explosion)
	queue_free()
