extends Area2D
class_name EnemyHitbox

#func _ready():
#	Signals.connect("you_are_invincible", self, "_they_are_invincible")
#
#func _they_are_invincible():
#	set_monitorable(false)
#	yield(get_tree().create_timer(30), "timeout")
#	set_monitorable(true)

#
#func _on_Area2D_body_entered(body):
#	if body.name == "Player":
#		body.get_hurt()
#
#	if body.name == "Companion":
#		body.get_hurted()

#deactivated for now, who knows if i could use this again

#shouldn't bother with get_node("CollisionShape2D").disabled because it'd be making Area2D call a node it doesn't have unless when it's under another scene
#guess Godot doesn't like the use of yield() either
