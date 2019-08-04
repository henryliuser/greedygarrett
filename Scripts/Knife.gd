extends Node2D
var onCooldown = false
var cdTimer = 0
onready var player = get_parent().get_parent()
onready var hbox = $hitbox/hitbox

func _physics_process(delta):
	if onCooldown:
		cdTimer += 1
		if cdTimer >= 18:
			cdTimer = 0
			onCooldown = false
	elif Input.is_action_just_pressed("shoot") and not onCooldown:
		onCooldown = true
		hbox.disabled = false
		position.y -= 80
		yield(get_tree().create_timer(delta),"timeout")
		hbox.disabled = true
		yield(get_tree().create_timer(0.15),"timeout")
		position.y += 80


func _on_hitbox_body_entered(body):
	if body.has_method("isEnemy"):
		var x = player.rotation-PI/2
		body.getHurt(20,Vector2(cos(x),sin(x))*5000)
