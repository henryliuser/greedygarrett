extends Area2D

onready var parent = get_parent()
onready var target = parent.get_parent().get_node("Player")

func _physics_process(delta):
	var direction = (target.global_position - self.global_position).normalized()
	parent.global_position += direction * delta * 100


func _on_Area2D_body_entered(body):
	if body.has_method("isPlayer"):
		body.getMoney(parent.denom)
		parent.queue_free()
