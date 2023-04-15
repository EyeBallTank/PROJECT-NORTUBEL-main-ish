extends ParallaxLayer


export var background = "res://assets/sprites/level_backgrounds/level bg test 2.png"
onready var spritenode = $Sprite

func _ready():
	spritenode.texture = load(background)
