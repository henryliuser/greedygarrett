extends Node2D
onready var enemies = $enemies.get_children()
func _physics_process(delta):
	if enemies.size() == 0:
		get_tree().change_scene("res://Menus/Shop.tscn")
