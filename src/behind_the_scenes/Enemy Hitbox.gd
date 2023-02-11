extends Area2D

var hitbox_timer : float = 0.5

func _on_Area2D_body_entered(body):
#	if body.name == "Player":
#		body.get_hurt()
##		hide()
#		yield(get_tree().create_timer(1), "timeout")
#		show()
	if body.name == "Companion":
		body.get_hurted()

#shouldn't bother with get_node("CollisionShape2D").disabled because it'd be making Area2D call a node it doesn't have unless when it's under another scene
#guess Godot doesn't like the use of yield() either
