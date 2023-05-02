extends Control

var ezcudo_score = Signals.score

onready var ScoreLabel = $ScoreLabel

func _ready():
	Signals.connect("coin_was_captured", self, "_on_CoinCaptured")

func _on_CoinCaptured():
	ezcudo_score += 1
	ScoreLabel.text = "Ezcudos: " + str(ezcudo_score)
	Signals.emit_signal("score_was_updated")

func _physics_process(_delta):
	if ezcudo_score == 3:
		ezcudo_score = 0
		ScoreLabel.text = "Ezcudos: " + str(ezcudo_score)
		Signals.emit_signal("new_life")
#		Signals.lives += 1
