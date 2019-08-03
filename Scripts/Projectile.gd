extends Area2D
var velocity = Vector2()
var damage = 34

func isProjectile():
	pass
	
func _physics_process(delta):
	position += velocity * delta

