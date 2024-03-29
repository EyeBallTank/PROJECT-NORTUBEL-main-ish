extends Node2D

#This was hard to implement and still looks weird right now
#Pay attention to the scene organization, nodes and SPECIALLY the pivot points then the code below

#onready var Companion = get_parent()
#onready var secret = $AstrolabeSecret
onready var secret = $Secret
onready var arrow = $Secret/Node2D/AstrolabeBase/AstrolabeArrow
onready var base = $Secret/Node2D/AstrolabeBase
onready var newnode = $Secret/Node2D
var target_position = null
#onready var testscreen = get_parent().get_node("res://src/menusandui/TestScreen.tscn")
#get_tree().get_root().get_node("TestScreet")
#onready var testscreen = get_tree().get_root().get_node("Companion/CanvasLayer/TestScreen")

func _process(_delta):
	var canvas = get_canvas_transform()
	var top_left = -canvas.origin / canvas.get_scale()
	var size = get_viewport_rect().size / canvas.get_scale()

	set_marker_position(Rect2(top_left, size))
	set_marker_rotation()

func set_marker_position(bounds : Rect2):
#	bounds = bounds.expand(Vector2(-964, -90000))
	if target_position == null:
		secret.global_position.x = clamp(global_position.x, bounds.position.x, bounds.end.x)
		secret.global_position.y = clamp(global_position.y, bounds.position.y, bounds.end.y)
#		arrow.global_position.x = clamp(global_position.x, bounds.position.x, bounds.end.x)
#		arrow.global_position.y = clamp(global_position.y, bounds.position.y, bounds.end.y)
#		base.global_position.x = clamp(global_position.x, bounds.position.x, bounds.end.x)
#		base.global_position.y = clamp(global_position.y, bounds.position.y, bounds.end.y)
	else:
		var displacement = global_position - target_position
		var length

		var tl = (bounds.position - target_position).angle()
		var tr = (Vector2(bounds.end.x, bounds.position.y) - target_position).angle()
		var bl = (Vector2(bounds.position.x, bounds.end.y) - target_position).angle()
		var br = (bounds.end - target_position).angle()
		if (displacement.angle() > tl && displacement.angle() < tr) \
				|| (displacement.angle() < bl && displacement.angle() > br):
			var y_length = clamp(displacement.y, bounds.position.y - target_position.y, \
					bounds.end.y - target_position.y)
			var angle = displacement.angle() - PI / 2.0
			length = y_length / cos(angle) if cos(angle) != 0 else y_length
		else:
			var x_length = clamp(displacement.x, bounds.position.x - target_position.x, \
					bounds.end.x - target_position.x)
			var angle = displacement.angle()
			length = x_length / cos(angle) if cos(angle) != 0 else x_length

		secret.global_position = polar2cartesian(length, displacement.angle()) + target_position
#		arrow.global_position = polar2cartesian(length, displacement.angle()) + target_position
#		base.global_position = polar2cartesian(length, displacement.angle()) + target_position

	if bounds.has_point(global_position):
		hide()
	else:
		show()

func set_marker_rotation():
	var angle = (global_position - secret.global_position).angle()
	secret.global_rotation = angle
	var angle2 = (global_position - newnode.global_position).angle()
	newnode.global_rotation = angle2
	base.global_rotation = 0
	var angle3 = (global_position - arrow.global_position).angle()
	arrow.global_rotation = angle3
