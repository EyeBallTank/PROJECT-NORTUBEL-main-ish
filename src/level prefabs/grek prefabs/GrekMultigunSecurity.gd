extends KinematicBody2D

var honk = false
onready var dialogue = $CanvasLayer
onready var elecplace = $Position2D
onready var animation = $AnimationPlayer

const Electricity = preload("res://src/level prefabs/grek prefabs/GrekElecTest.tscn")

#HOW DO I MAKE IT SO IT ONLY TAKES ONE LIFE FROM THE PLAYER?
#TAKING 2 LIVES WHEN THE PLAYER HAS 1 MEANS A SOFTLOCK BECAUSE THE GAME
#DOESN'T KNOW WHAT TO DO WHEN THERE'S "LESS THAN 0" LIVES


func _ready():
	dialogue.visible = false
	animation.play("RESET")

func _physics_process(delta):
	if honk == true:
		if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("standstill"):
			animation.play("active")
		if Input.is_action_just_pressed("followme"):
			animation.play("active")
#		if Input.is_action_just_pressed("attack"):
#			animation.play("active")

func _on_TalkToArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		honk = true
#		attack()
#		animation.play("active")

func _on_TalkToArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
		honk = false

func attack():
	Signals.emit_signal("grek_gun_active")
#	var projectile = Electricity.instance()
#	projectile.global_position = elecplace.global_position
#	get_tree().get_root().add_child(projectile)


func _on_Hurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		animation.play("active")
