extends Node2D
#class_name main_level_script

func _tree_entered():  
	#Send all new nodes to register_node()
	get_tree().connect("node_added", self, "register_node") 


func register_node(node:Node):
	#Here is where you can add more "if" statements to filter which nodes are affected  
	if node.owner == null:
		node.owner = get_tree().current_scene
