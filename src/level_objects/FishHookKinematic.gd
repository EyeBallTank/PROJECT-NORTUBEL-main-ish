extends Node2D

onready var anchorsprite = $Sprite
export var anchorspritename = "nortubel anchor"
onready var hooksprite = $FishHookWithWire/Sprite
export var hookspritename = "nortubel hook"


func _ready():
	anchorsprite.animation = anchorspritename
	hooksprite.animation = hookspritename
