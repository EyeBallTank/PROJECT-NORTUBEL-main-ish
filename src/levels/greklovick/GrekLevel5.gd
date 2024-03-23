extends Node2D

onready var animation = $AnimationPlayer
#yiegourattacksone
onready var shieldgen1 = $ShieldGenerator1
onready var shieldgen2 = $ShieldGenerator2
onready var shieldgen3 = $ShieldGenerator3
onready var shieldgen4 = $ShieldGenerator4
onready var shieldgen5 = $ShieldGenerator5
onready var shieldgen6 = $ShieldGenerator6

var switchone = false
var switchtwo = false
var switchthree = false
var switchfour = false
var switchfive = false
var switchsix = false

var switchespressed = 0


#The leve could use a script of its own

func _ready():
	pass 

#func _physics_process(delta):
#	if switchespressed == 2:
#		send_a_signal()

func send_a_signal():
	Signals.emit_signal("turn_off_zhark_shield")

func switch_pressed():
	switchespressed += 1



#func _on_ButtonPress_body_entered(body):
#	if body.is_in_group("protagonists"):
#		send_a_signal()
#		animation.play("yiegourattacks")


func _on_ButtonPress6_body_entered(body):
	if body.is_in_group("protagonists"):
		switchsix = true

func _on_ButtonPress5_body_entered(body):
	if body.is_in_group("protagonists"):
		switchfive = true

func _on_ButtonPress4_body_entered(body):
	if body.is_in_group("protagonists"):
		switchfour = true

func _on_ButtonPress3_body_entered(body):
	if body.is_in_group("protagonists"):
		switchthree = true

func _on_ButtonPress2_body_entered(body):
	if body.is_in_group("protagonists"):
		switchtwo = true

func _on_ButtonPress1_body_entered(body):
	if body.is_in_group("protagonists"):
		switchone = true
