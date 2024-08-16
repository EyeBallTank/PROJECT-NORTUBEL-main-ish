extends KinematicBody2D

onready var animation = $AnimationPlayer
onready var sprite = $AnimatedSprite
export var charactername = "voodoo melvin"

onready var hurtbyenemy = $PainReceiveEnemy
onready var hurtbyplayer = $PainReceiveYou

func _ready():
	sprite.animation = charactername
	animation.play("RESET")
	


func hurt_the_player():
	Signals.emit_signal("voodoo_hurts_player")


func _on_PainReceiveEnemy_area_entered(area):
	if area.name == "EnemyHitbox":
		animation.play("doll_hurt")



func _on_PainReceiveYou_area_entered(area):
	if area.name == "PlayerMelee":
		animation.play("doll_hurt")
