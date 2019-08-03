extends Area2D

onready var parent = get_parent()
onready var target = parent.get_parent().get_node("Player")
var velocity = Vector2()
var counter = 0
var initialSpeed = Vector2(randi()%100 - randi()%100, randi()%100 - randi()%100)

func _ready():
	randomize()
	velocity = initialSpeed * 150

func _physics_process(delta):
	if(counter > 40):
		var direction = (target.global_position - self.global_position).normalized()
		parent.global_position += direction * delta * 100
	else:
		counter+=1
		var direction = velocity.normalized()
		velocity = lerp(velocity, delta*direction*100, 0.3)
		parent.global_position += velocity * delta


func _on_Area2D_body_entered(body):
	if body.has_method("isPlayer"):
		body.getMoney(parent.denom)
		parent.queue_free()
