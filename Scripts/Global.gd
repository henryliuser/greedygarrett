extends Control
var health
var money

var hurtColor = Color(0.5, 0, 1, 0.5)

func _process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()

static func lerp_angle(from, to, weight):
    return from + short_angle_dist(from, to) * weight

static func short_angle_dist(from, to):
    var max_angle = PI * 2
    var difference = fmod(to - from, max_angle)
    return fmod(2 * difference, max_angle) - difference

func changeScene(hp, cash, scene): #maintain player hp between rooms
	health = hp 
	money = cash
	get_tree().change_scene(scene)
	
func gameOver():
	health = 100
	get_tree().change_scene("res://Menus/GameOver.tscn")
	
	