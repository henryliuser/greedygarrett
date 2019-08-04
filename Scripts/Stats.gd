extends CanvasLayer

onready var hp = $HPCash/HP
onready var cash = $HPCash/Cash
var health = 100
var money = 0.0
var armor = 0

#ammo
onready var ammo = $HPCash/Ammo
var currentWeapon = 0
var ammunition = [5,5,5,5,25,NAN] # [bullets,rays,shells,rockets,energy,NAN]
						#	         [   0   ,  1 ,   2  ,   3   ,  4   , 5 ]
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
	if health > 100:
		health = 100
	hp.text = "HP: " + str(health)

func subtractHealth(dmg):
	if armor == 0:
		health -= dmg
	else:
		health -= dmg/2
	subtractArmor(dmg)
	hp.text = "HP: " + str(health)
	if health <= 0:
		Global.gameOver()

func subtractArmor(dmg):
	armor -= dmg
	if armor < 0:
		armor = 0

func addArmor(dmg):
	armor += dmg
	if armor > 100:
		armor = 100

#we need to update on weapon switch too
func updateAmmo(type):
	ammunition[type] -= 1
	ammo.text = "Ammo: " + str(ammunition[type])

func changeWeapon(num):
	ammo.text = "Ammo: " + str(ammunition[num])

func reset():
	health = 100
	money = 0.0
	armor = 0
	
	currentWeapon = 0
	ammunition = [10,10,10,10,50,NAN] # [bullets,rays,shells,rockets,energy,NAN]
	hp.text = "HP: " + str(health)
	formatCash()
	
	
	
	