extends Node2D

export var voodooplayerhealth : int = 250
onready var healthbar = $CanvasLayer/ProgressBar


func _ready():
	Signals.connect("voodoo_hurts_player", self, "_voodoo_player_health_goes_down")
	healthbar.max_value = voodooplayerhealth

func _physics_process(delta):
	healthbar.value = voodooplayerhealth
	if voodooplayerhealth <= 0:
		might_die()

func might_die():
	SceneManager.change_scene("level_transition_effect", "res://screens/GameOver.tscn")

func _voodoo_player_health_goes_down():
	voodooplayerhealth -= 10
