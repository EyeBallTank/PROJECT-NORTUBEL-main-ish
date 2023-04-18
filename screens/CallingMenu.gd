extends Control

func _process(_delta):
	if Input.is_action_just_pressed("kickball"):
		toggle()

func toggle():
	visible = !visible
#	get_tree().paused = visible
	if Input.is_action_just_pressed("followme"):
#		get_tree().paused = false
		hide()
	if Input.is_action_just_pressed("standstill"):
#		get_tree().paused = false
		hide()
	if Input.is_action_just_pressed("runaway"):
#		get_tree().paused = false
		hide()

func _ready():
	hide()

#func _on_UnpauseButton_pressed():
#	hide()
#	get_tree().paused = false
