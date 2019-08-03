extends CanvasLayer

onready var hp = $HPCash/HP
onready var cash = $HPCash/Cash
var health = 100
var money = 0.9

func _ready():
	formatCash()
	hp.text = "HP: " + str(health)

func addFunds(add):
	money += add
	if money > 1.00:
		money -= 1.0
		subtractHealth(15)
	formatCash()

func subtractFunds(sub):
	money -= sub
	formatCash()

func formatCash():
	cash.text = "$%.2f"%money

func addHealth(dmg):
	health += dmg
	hp.text = "HP: " + str(health)

func subtractHealth(dmg):
	health -= dmg
	hp.text = "HP: " + str(health)
	if health <= 0:
		Global.gameOver()