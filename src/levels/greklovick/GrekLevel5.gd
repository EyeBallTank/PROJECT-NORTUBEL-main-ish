extends Node2D

onready var animation = $AnimationPlayer
#yiegourattacksone
onready var shieldgen1 = $ShieldGenerator1/AnimatedSprite
onready var shieldgen2 = $ShieldGenerator2/AnimatedSprite
onready var shieldgen3 = $ShieldGenerator3/AnimatedSprite
onready var shieldgen4 = $ShieldGenerator4/AnimatedSprite
onready var shieldgen5 = $ShieldGenerator5/AnimatedSprite
onready var shieldgen6 = $ShieldGenerator6/AnimatedSprite
onready var sound = $AudioStreamPlayer2

var switchone = false
var switchtwo = false
var switchthree = false
var switchfour = false
var switchfive = false
var switchsix = false

var switchespressed = 0


#The leve could use a script of its own

func _ready():
	animation.play("RESET")
	shieldgen1.animation = "on"
	shieldgen2.animation = "on"
	shieldgen3.animation = "on"
	shieldgen4.animation = "on"
	shieldgen5.animation = "on"
	shieldgen6.animation = "on"

func _physics_process(delta):
	pass

#	if switchespressed == 2:
#		animation.play("yiegourattacksone")

func send_a_signal():
	Signals.emit_signal("turn_off_zhark_shield")

func switch_pressed():
	switchespressed += 1



#func _on_ButtonPress_body_entered(body):
#	if body.is_in_group("protagonists"):
#		send_a_signal()
#		animation.play("yiegourattacks")


func _on_ButtonPress6_body_entered(body):
	sound.play()
	if body.is_in_group("protagonists") and switchfive == false:
		switchsix = true
		shieldgen6.animation = "off"
		switch_pressed()
	elif body.is_in_group("protagonists") and switchfive == true:
		animation.play("yiegourattacksthree")
		send_a_signal()

func _on_ButtonPress5_body_entered(body):
	sound.play()
	if body.is_in_group("protagonists") and switchsix == false:
		switchfive = true
		shieldgen5.animation = "off"
		switch_pressed()
	elif body.is_in_group("protagonists") and switchsix == true:
		animation.play("yiegourattacksthree")
		send_a_signal()

func _on_ButtonPress4_body_entered(body):
	sound.play()
	if body.is_in_group("protagonists") and switchone == false:
		switchfour = true
		shieldgen4.animation = "off"
		switch_pressed()
	elif body.is_in_group("protagonists") and switchone == true:
		animation.play("yiegourattacksone")
		send_a_signal()

func _on_ButtonPress3_body_entered(body):
	sound.play()
	if body.is_in_group("protagonists") and switchtwo == false:
		switchthree = true
		shieldgen3.animation = "off"
		switch_pressed()
	elif body.is_in_group("protagonists") and switchtwo == true:
		animation.play("yiegourattackstwo")
		send_a_signal()

func _on_ButtonPress2_body_entered(body):
	sound.play()
	if body.is_in_group("protagonists") and switchthree == false:
		switchtwo = true
		shieldgen2.animation = "off"
		switch_pressed()
	elif body.is_in_group("protagonists") and switchthree == true:
		animation.play("yiegourattackstwo")
		send_a_signal()

func _on_ButtonPress1_body_entered(body):
	sound.play()
	if body.is_in_group("protagonists") and switchfour == false:
		switchone = true
		shieldgen1.animation = "off"
		switch_pressed()
	elif body.is_in_group("protagonists") and switchfour == true:
		animation.play("yiegourattacksone")
		send_a_signal()
