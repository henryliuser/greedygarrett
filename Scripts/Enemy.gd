extends KinematicBody2D

onready var parent = get_parent()
var playerInRange = false
export var health = 100
onready var target = $target
var targetPos
var coins = ["res://Objects/Penny.tscn","res://Objects/Nickel.tscn","res://Objects/Dime.tscn","res://Objects/Quarter.tscn"]

#hitstun
const stun = 18
var hitstun = 0
var hitVelo = Vector2()

func _ready():
	target.global_position = Vector2(randi()%1600, randi()%900)
	targetPos = target.global_position
	parent.playerPos = target.global_position
	randomize()

func isEnemy():
	pass

func move():
	if playerInRange:
		parent.playerPos = target.global_position
		var direction = (target.global_position - global_position).normalized()
		parent.move_and_slide(direction * parent.speed)
	else:
		var direction = (targetPos - global_position).normalized()
		parent.move_and_slide(direction * parent.speed)
		if abs(targetPos.x - global_position.x) < 50 and abs(targetPos.y - global_position.y) < 50:
			target.global_position = Vector2(randi()%1600, randi()%900)
			parent.playerPos = target.global_position
			targetPos = target.global_position
		


func _physics_process(delta):
	if hitstun != 0:
		calculateHitstun()
	else:
		move()

func calculateHitstun():
	hitstun += 1
	hitVelo = lerp(hitVelo, Vector2(0,0), 0.3)
	if hitstun <= 10:
		parent.move_and_slide(hitVelo)
	if hitstun >= stun:
		hitstun = 0
	

func _on_hitbox_area_entered(body):
	if body.has_method("isProjectile"):
		if body.damage > 0:
			health -= body.damage
			hitstun = 1
			hitVelo = body.velocity/2
			parent.move_and_slide(body.velocity/2)
			if health <= 0:
				parent.queue_free()
				coinExplode()
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
		parent.get_parent().get_parent().add_child(coin)

func getHurt(dmg, velocity):
	health -= dmg
	hitstun = 1
	if health <= 0:
		parent.queue_free()
		coinExplode()
	parent.move_and_slide(velocity)
	hitVelo = velocity


func _on_hitbox_body_entered(body):
	if body.has_method("isPlayer"):
		var x = parent.rotation-PI/2
		body.getHit(10, Vector2(cos(x),sin(x))*5000 )


func _on_playerDetector_body_entered(body):
	if body.has_method("isPlayer"):
		playerInRange = true
		target = body
		parent.playerPos = target.global_position
		#get_node("playerDetector/CollisionShape2D").shape.radius = 300 breaks the code


func _on_playerDetector_body_exited(body):
	if body.has_method("isPlayer"):
		playerInRange = false
		target = $target
		target.global_position = Vector2(randi()%1600, randi()%900)
		parent.playerPos = target.global_position
		targetPos = target.global_position
		#get_node("playerDetector/CollisionShape2D").shape.radius = 200 breaks the code