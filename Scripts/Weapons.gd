extends Node2D
var weapons = get_children()
var currentWeapon = 0
func _physics_process(delta):
	weapons = get_children()
	if Input.is_action_just_pressed("switch"):
		currentWeapon += 1
		if currentWeapon >= weapons.size():
			currentWeapon = 0
		for x in range(0,weapons.size()):
			if x== currentWeapon:
				weapons[x].current = true
				weapons[x].visible = true
				continue
			weapons[x].current = false
			weapons[x].visible = false
			
		Stats.changeWeapon(weapons[currentWeapon].num)