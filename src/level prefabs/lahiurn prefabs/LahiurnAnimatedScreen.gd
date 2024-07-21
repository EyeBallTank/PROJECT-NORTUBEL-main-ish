extends Node2D

onready var sprites = $AnimatedSprite

func _ready():
	sprites.play("default")
	Signals.connect("katrin_was_seen", self, "_screen_shows_katrin")

func _screen_shows_katrin():
	sprites.play("caught")
