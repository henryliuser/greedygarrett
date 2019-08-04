extends Node2D

func _on_Pistol_body_entered(body):
	if Stats.money >= 0.1:
		Stats.ammunition[0] += 11
		Stats.money -= 0.1
		Stats.formatCash()
		Stats.updateAmmo(0)
func _on_Sniper_body_entered(body):
	if Stats.money >= 0.5:
		Stats.ammunition[1] += 11
		Stats.money -= 0.5
		Stats.formatCash()
		Stats.updateAmmo(1)
func _on_Shotgun_body_entered(body):
	if Stats.money >= 0.3:
		Stats.ammunition[2] += 11
		Stats.money -= 0.3
		Stats.formatCash()
		Stats.updateAmmo(2)
func _on_Bazooka_body_entered(body):
	if Stats.money >= 0.7:
		Stats.ammunition[3] += 11
		Stats.money -= 0.7
		Stats.formatCash()
		Stats.updateAmmo(3)
func _on_Beam_Dagger_body_entered(body):
	if Stats.money >= 0.9:
		Stats.ammunition[4] += 101
		Stats.money -= 0.9
		Stats.formatCash()
		Stats.updateAmmo(4)
		

func _on_HP_body_entered(body):
	if Stats.money >= 0.4:
		Stats.addArmor(40)
		Stats.money -= 0.4


func _on_ARMOUR_body_entered(body):
	if Stats.money >= 0.4:
		Stats.addHealth(40)
		Stats.money -= 0.4
