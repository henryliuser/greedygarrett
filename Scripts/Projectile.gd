extends Area2D
var velocity = Vector2()
var damage = 1

func isProjectile():
	pass
	
func _physics_process(delta):
	position += velocity * delta

