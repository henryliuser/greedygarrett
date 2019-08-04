extends Sprite
export var projectileSpeed = 3000
onready var bullets = get_parent().get_parent().get_parent()
onready var open = $opening
export var cooldown = 2
export var damage = 150
onready var player = get_parent().get_parent()
var onCooldown = false
var cdTimer = 0

func _ready():
	randomize()

func _physics_process(delta):
	if onCooldown:
		cdTimer += 1
		if cdTimer >= 120:
			cdTimer = 0
			onCooldown = false
	elif Input.is_action_just_pressed("shoot") and not onCooldown:
		shoot()

func shoot(): #SCREENSHAKE
	onCooldown = true
	position.y += 24
	var scatter = 0.0
	for i in range(0,8):
		var bull = load("res://Objects/ShotgunProjectile.tscn").instance()
		var rot = player.rotation - PI/2 + (randi()%1000)/1000.0 - 0.5#+ scatter/7 - 0.5
		scatter += 1
		bull.rotation = rot + PI/2
		bull.velocity = projectileSpeed * (randi()%1000)/1000.0 * Vector2(cos(rot),sin(rot))
		bull.global_position = open.global_position
		bullets.add_child(bull)
	yield(get_tree().create_timer(0.3), "timeout") 
	position.y -= 24
	