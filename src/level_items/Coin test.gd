extends Area2D
#script will still be basic, if there's no score system yet


func _ready():
	pass # Replace with function body.


func _on_Coin_body_entered(body):
	if body.is_in_group("protagonists"):
		queue_free()
