extends KinematicBody2D
onready var player = get_parent().get_parent().get_node("Player")
onready var targetPos = player.global_position
onready var direction = (targetPos - self.global_position).normalized()
onready var parent = get_parent()
export var health = 100
var counter = 0
var coins = ["res://Objects/Penny.tscn","res://Objects/Nickel.tscn","res://Objects/Dime.tscn","res://Objects/Quarter.tscn"]

func isEnemy():
	pass

func move(delta):
	if counter <= 180:
		parent.global_position += (targetPos - self.global_position).normalized() * delta * 1200
		counter += 1
	else:
		counter = 0
		targetPos = player.global_position
		direction = (targetPos - self.global_position).normalized()
		


func _process(delta):
	move(delta)


func _on_hitbox_area_entered(body):
	if body.has_method("isProjectile"):
		if body.damage > 0:
			health -= body.damage
			if health <= 0:
				parent.queue_free()
				coinExplode()
		parent.move_and_slide(body.velocity*0.5)
		body.queue_free()

func coinExplode():
	for i in range(0,randi()%5+1):
		var x = randi()%100
		var coin
		if x < 50:
			coin = load(coins[0]).instance()
		elif x < 80:
			coin = load(coins[1]).instance()
		elif x < 95:
			coin = load(coins[2]).instance()
		else:
			coin = load(coins[3]).instance()
		coin.global_position = global_position
		parent.get_parent().add_child(coin)

func getHurt(dmg, velocity):
	health -= dmg
	if health <= 0:
		parent.queue_free()
		coinExplode()
	parent.move_and_slide(velocity)


func _on_hitbox_body_exited(body):
	pass # Replace with function body.