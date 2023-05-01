extends Control

var life_count = 0

onready var LifeLabelNumber = $LifeLabelNumber

#func _ready():
#	Signals.connect("coin_was_captured", self, "_on_CoinCaptured")
#
#func _on_CoinCaptured():
#	life_count += 1
#	LifeLabelNumber.text = str(life_count)
#	Signals.emit_signal("score_was_updated")
