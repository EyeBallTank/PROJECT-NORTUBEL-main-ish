extends Node

onready var animationplayer = $AnimationPlayer
export var nextscene = "res://src/levels/LevelTemplate.tscn"

#maybe i should work on this later because i need to consider:
#* HOW MODULAR WILL THESE TYPE OF SCENE BE IN OTHER INSTANCES/USES
#* NUMBER OF SLIDE IMAGES AND DIALOGUE TEXTS
#* HOW LONG CERTAIN IMAGES STAY, SINCE THERE WILL ALWAYS BE MUCH MORE TEXT TO CHANGE
#* AND PROBABLY MORE

func _ready():
	animationplayer.play("intro cutscene")

func _process(_delta):
	if Input.is_action_just_pressed("kickball"):
		SceneManager.change_scene("level_transition_effect", nextscene)

func cutscene_over():
	SceneManager.change_scene("level_transition_effect", nextscene)
