extends Sprite
var current = false
export var projectileSpeed = 300
onready var bullets = get_parent().get_parent().get_parent()
onready var open = $opening
var num = 3
export var cooldown = 90
export var damage = 150
onready var player = get_parent().get_parent()
var onCooldown = false
var cdTimer = 0

func _ready():
	randomize()

func _physics_process(delta):
	if current:
		if onCooldown:
			cdTimer += 1
			if cdTimer >= cooldown:
				cdTimer = 0
				onCooldown = false
		elif Input.is_action_just_pressed("shoot") and not onCooldown:
			if Stats.ammunition[3] > 0:
				shoot()

func shoot(): #SCREENSHAKE
	Stats.updateAmmo(3)
	onCooldown = true
	position.y += 24
	var bull = load("res://Objects/BazookaProjectile.tscn").instance()
	var rot = player.rotation - PI/2
	bull.rotation = rot + PI/2
	bull.velocity = projectileSpeed * Vector2(cos(rot),sin(rot))
	bull.global_position = open.global_position
	bullets.add_child(bull)
	yield(get_tree().create_timer(0.3), "timeout") 
	position.y -= 24
	