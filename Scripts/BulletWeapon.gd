extends Sprite
export var projectileSpeed = 3000
var num = 0
var current = false
onready var bullets = get_parent().get_parent().get_parent()
onready var open = $opening

func _physics_process(delta):
	if current:
		if Input.is_action_just_pressed("shoot"):
			if Stats.ammunition[0] > 0:
				shoot()
		

func shoot(): #SCREENSHAKE
	Stats.updateAmmo(0)
	position.y += 16
	var bull = load("res://Objects/Projectile.tscn").instance()
	var rot = get_parent().get_parent().rotation - PI/2
	bull.rotation = rot + PI/2
	bull.velocity = projectileSpeed * Vector2(cos(rot),sin(rot))
	bull.global_position = open.global_position
	bullets.add_child(bull)
	yield(get_tree().create_timer(0.15), "timeout") 
	position.y -= 16
	