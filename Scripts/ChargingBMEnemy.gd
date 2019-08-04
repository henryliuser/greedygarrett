extends KinematicBody2D
onready var player = get_parent().get_parent().get_node("Player")
onready var targetPos = player.global_position
onready var direction = (targetPos - self.global_position).normalized()
onready var parent = get_parent()
export var health = 100
var counter = 0
var coins = ["res://Objects/Penny.tscn","res://Objects/Nickel.tscn","res://Objects/Dime.tscn","res://Objects/Quarter.tscn"]

const stun = 18
var hitstun = 0
var hitVelo = Vector2()

func isEnemy():
	pass

func move(delta):
	if abs(targetPos.x - global_position.x) < 50 and abs(targetPos.y - global_position.y) < 50:
		counter+= 1
		if counter >= 100:
			counter = 0
			targetPos = player.global_position
			direction = (targetPos - self.global_position).normalized()
	else:
		parent.global_position += (targetPos - self.global_position).normalized() * delta * 1200

func calculateHitstun():
	hitstun += 1
	hitVelo = lerp(hitVelo, Vector2(0,0), 0.3)
	if hitstun <= 10:
		parent.move_and_slide(hitVelo)
	if hitstun >= stun:
		hitstun = 0


func _physics_process(delta):
	if hitstun != 0:
		calculateHitstun()
	else:
		move(delta)


func _on_hitbox_area_entered(body):
	if body.has_method("isProjectile"):
		if body.damage > 0:
			health -= body.damage
			hitstun = 1
			if health <= 0:
				parent.queue_free()
				coinExplode()
		hitVelo = body.velocity/2
		parent.move_and_slide(body.velocity/2)
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
	hitstun = 1
	if health <= 0:
		parent.queue_free()
		coinExplode()
	parent.move_and_slide(velocity)
	hitVelo = velocity


func _on_hitbox_body_exited(body):
	pass # Replace with function body.