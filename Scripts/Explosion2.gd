extends Area2D
var damage = 60
var one = 0
func _physics_process(delta):
	one += 1
	if one == 10:
		queue_free()

func _on_Explosion2_body_entered(body):
	if body.has_method("getHurt"):
		body.getHurt(damage, Vector2())

func _on_OuterExplosion_body_entered(body):
	if body.has_method("getHurt"):
		body.getHurt( damage, (body.global_position - global_position).normalized() * 8000 )