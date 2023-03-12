extends Area2D

export(int) var id = 0

var lockPortal = false

func LockedPortal():
	lockPortal = true
	yield(get_tree().create_timer(0.5), "timeout")
	lockPortal = false

func _ready():
	pass
