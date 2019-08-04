extends Node2D

export var spawned = "res://Objects/BadMan.tscn"
export var numberToSpawn = 4
export var delay = 300
var currTime = 0

func _process(delta):
	currTime += 1
	if currTime >= delay:
		var enemy = load(spawned).instance()
		enemy.global_position = global_position
		get_parent().add_child(enemy)
	