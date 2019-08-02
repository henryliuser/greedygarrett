extends Area2D

onready var parent = get_parent()
onready var target = get_node("res://Objects/Player.tscn")

func _process(delta):
	var direction = (target.global_position - global_position).normalized()
	parent.move_and_slide(direction)


func _on_Area2D_body_entered(body):
	if body.has_method("isPlayer"):
		pass #implement coin disappearance and player cash added
