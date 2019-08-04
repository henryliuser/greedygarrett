extends Sprite

export var cooldown = 2
export var damage = 150
onready var laser = $lazor
onready var player = get_parent().get_parent()
var onCooldown = false
var cdTimer = 0

func _ready():
	laser.enabled = true

func _physics_process(delta):
	if onCooldown:
		cdTimer += 1
		if cdTimer >= 120:
			cdTimer = 0
			onCooldown = false
	elif Input.is_action_just_pressed("shoot") and not onCooldown:
		if Stats.rays > 0:
			shoot()

func shoot():
	Stats.rays -= 1
	onCooldown = true
	var x = player.rotation-PI/2
	player.position -= Vector2(cos(x),sin(x))*40
	position.y += 35
	if laser.is_colliding():
		var obj = laser.get_collider()
		if obj.has_method("getHurt"):
			obj.getHurt(damage,laser.cast_to.normalized()*400)
	yield(get_tree().create_timer(0.5), "timeout")
	position.y -= 35
	
	
	