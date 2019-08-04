extends Control

func _ready():
	Stats.get_node("HPCash").visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	if Input.is_action_just_pressed("spwace"):
		Stats.reset()
		Stats.get_node("HPCash").visible = true
		get_tree().change_scene("res://Levels/henryTest.tscn")

