extends Control

# The number and name are seperate label nodes because the name uses the translation method
# while the number is called by code

var life_count = Signals.lives
onready var LifeLabelNumber = $LifeLabelNumber

func _ready():
	LifeLabelNumber.text = ": " + str(life_count)
	Signals.connect("new_life", self, "_life_received")
	Signals.connect("life_lost", self, "_lost_a_life")

func _life_received():
	Signals.lives += 1
	LifeLabelNumber.text = ": " + str(life_count)
	life_count = Signals.lives

func _lost_a_life():
#	life_count -= 1
#	yield(Signals, "life_lost")
	LifeLabelNumber.text = ": " + str(life_count)
	life_count = Signals.lives

func _physics_process(_delta):
	LifeLabelNumber.text = ": " + str(life_count)
