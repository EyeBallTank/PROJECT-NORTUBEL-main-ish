extends Area2D


func _ready():
	pass



func _on_SoccerBallBag_body_entered(body):
	if body.name == "Player":
		body.hasball = true
