extends CanvasLayer

onready var animatedsprite = $AnimatedSprite
onready var animationplayer = $AnimationPlayer
export var worldname = "nortubel"
#
#This is something that shows up when you enter a specific world
#
func _ready():
	animatedsprite.animation = worldname
	animationplayer.play("worldtitle")
