extends Node2D
var current = false
var on = false
var timer = 0
var increment = 60
var num = 4

onready var hbox = $hitbox/yuh

var bodies = []

func _physics_process(delta):
	if current:
		if on:
			timer += 1
			if timer >= 30:
				timer = 0
				Stats.updateAmmo(4) 
			for x in bodies:
				x.getHurt(2, Vector2())
			
		if Input.is_action_just_pressed("shoot"):
			if on: 
				on = false
				$blade.visible = false
				hbox.disabled = true
			else:
				on = true
				$blade.visible = true
				hbox.disabled = false
		

func _on_hitbox_body_entered(body):
	if current:
		if body.has_method("isEnemy"):
			bodies.append(body)

func _on_hitbox_body_exited(body):
	if current:
		if body.has_method("isEnemy"):
			bodies.remove(bodies.find(body))