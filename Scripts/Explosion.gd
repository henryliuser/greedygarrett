extends Area2D
onready var collShape = get_node("test/CollisionShape2D")# i genuinely dont know how this works or why
var counter = 0
var damage = 50

func _ready():
	collShape.shape.radius = 0.0

func _process(delta):
	counter += 1
	collShape.shape.radius = counter * (30.0/9)
	if counter > 90:
		queue_free()


func _on_Explosion_body_entered(body):
	if body.has_method("getHurt"):
			body.getHurt(damage,Vector2())


func _on_test_body_entered(body):
	if body.has_method("getHurt"):
			body.getHurt(damage,Vector2())
