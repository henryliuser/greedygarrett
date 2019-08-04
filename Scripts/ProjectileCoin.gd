extends Area2D

onready var target = get_parent().get_node("Player")
onready var targetPos = target.global_position
onready var direction = (targetPos - self.global_position).normalized()
var denom = .25

func _physics_process(delta):
	global_position += direction * delta * 1200

func _on_ProjectileCoin_body_entered(body):
	if body.has_method("isPlayer"):
		body.getMoney(denom)
		queue_free()
