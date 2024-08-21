extends Node2D

export var voodoocompanionhealth : int = 160
onready var healthbar = $CanvasLayer/ProgressBar


func _ready():
	Signals.connect("voodoo_hurts_companion", self, "_voodoo_companion_health_goes_down")
	healthbar.max_value = voodoocompanionhealth

func _physics_process(delta):
	healthbar.value = voodoocompanionhealth
	if voodoocompanionhealth <= 0:
		might_die()

func might_die():
	SceneManager.change_scene("level_transition_effect", "res://screens/GameOver.tscn")

func _voodoo_companion_health_goes_down():
	voodoocompanionhealth -= 10
