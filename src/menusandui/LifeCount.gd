extends Control

# The number and name are seperate label nodes because the name uses the translation method
# while the number is called by code

var life_count = 0

onready var LifeLabelNumber = $LifeLabelNumber

#func _ready():
#	Signals.connect("coin_was_captured", self, "_on_CoinCaptured")
#
#func _on_CoinCaptured():
#	life_count += 1
#	LifeLabelNumber.text = str(life_count)
#	Signals.emit_signal("score_was_updated")
