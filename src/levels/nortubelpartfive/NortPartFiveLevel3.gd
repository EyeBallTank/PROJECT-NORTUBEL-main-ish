extends Node2D

onready var animation = $AnimationPlayer
onready var musicplayer = $MusicPlayer
onready var whenyouwin = $WhenYouWin

func _ready():
	musicplayer.play("RESET")
	whenyouwin.play("RESET")


func _on_WhenSpidersAreGone_body_entered(body):
	if body.is_in_group("protagonists"):
		musicplayer.play("SpidersAreGone")
		whenyouwin.play("GoodBye")
