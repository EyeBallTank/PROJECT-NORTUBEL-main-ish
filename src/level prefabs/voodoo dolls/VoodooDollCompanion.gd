extends KinematicBody2D

onready var sprite = $AnimatedSprite
export var charactername = "voodoo angela"

onready var hurtbyenemy = $PainReceiveEnemy
onready var hurtbyplayer = $PainReceiveYou

func _ready():
	sprite.animation = charactername
