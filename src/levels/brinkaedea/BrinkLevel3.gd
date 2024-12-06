extends Node2D


onready var animationplayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("bonkette_song_must_play", self, "_oh_no_bonkette_is_here")
	animationplayer.play("RESET")

func _oh_no_bonkette_is_here():
	animationplayer.play("BonketteArrives")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
