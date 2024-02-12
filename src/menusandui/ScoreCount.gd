extends Control

var ezcudo_score = Signals.score

onready var ScoreLabel = $ScoreLabel

func _ready():
# warning-ignore:return_value_discarded
	Signals.connect("coin_was_captured", self, "_on_CoinCaptured")

func _on_CoinCaptured():
	Signals.score += 1
	ezcudo_score = Signals.score
	ScoreLabel.text = "Ezcudos: " + str(ezcudo_score)
	Signals.emit_signal("score_was_updated")
	if ezcudo_score == 15:
		Signals.score = 0
		ezcudo_score = Signals.score
		ScoreLabel.text = "Ezcudos: " + str(ezcudo_score)
		Signals.emit_signal("new_life")
#Still returns to 0 in the next level
#Now it might be fixed, ignore the commented out text above

func _physics_process(_delta):
	ScoreLabel.text = "Ezcudos: " + str(ezcudo_score)
#	if ezcudo_score == 3:
#		Signals.score = 0
#		ScoreLabel.text = "Ezcudos: " + str(ezcudo_score)
#		Signals.emit_signal("new_life")
#		Signals.add_life()
#		Signals.lives += 1
