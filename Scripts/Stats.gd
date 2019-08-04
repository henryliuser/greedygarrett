extends CanvasLayer

onready var hp = $HPCash/HP
onready var cash = $HPCash/Cash
var health = 100
var money = 0.0

#ammo
onready var ammo = $HPCash/Ammo
var currentWeapon = 0
var ammunition = [10,10,0,0] # [bullets,rays,shells,rockets]
						#	 [   0   ,  1 ,   2  ,   3   ]
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
	cash.text = "$%.2f" % money

func addHealth(dmg):
	health += dmg
	hp.text = "HP: " + str(health)

func subtractHealth(dmg):
	health -= dmg
	hp.text = "HP: " + str(health)
	if health <= 0:
		Global.gameOver()

#we need to update on weapon switch too
func updateAmmo(type):
	ammunition[type] -= 1
	ammo.text = "Ammo: " + str(ammunition[type])
