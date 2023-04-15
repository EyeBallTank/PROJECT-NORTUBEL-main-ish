extends ParallaxLayer


export var background = "res://assets/sprites/level_backgrounds/level bg test 2.png"
onready var spritenode = $Sprite
# Called when the node enters the scene tree for the first time.
func _ready():
	spritenode.texture = load(background)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
