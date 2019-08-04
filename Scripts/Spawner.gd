extends Node2D

export var spawned = ["res://Objects/BadMan.tscn", "res://Objects/CoinShootBM.tscn", "res://Graphics/ChargingBM.tscn", "res://Objects/BossBM.tscn"]
export var numberToSpawn = 2
export var delay = 300
var numSpawned = 0
var currTime = 300

func _ready():
	randomize()
	numberToSpawn = randi()%4
	global_position = Vector2(randi()%1920, randi()%1080)

func _process(delta):
	currTime += 1
	if currTime >= delay:
		currTime = 0
		if numSpawned <= numberToSpawn:
			var enemy = load(spawned[randi()%4]).instance()
			enemy.global_position = global_position
			get_parent().get_node("enemies").add_child(enemy)
			numSpawned += 1