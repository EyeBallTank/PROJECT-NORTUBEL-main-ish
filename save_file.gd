extends Node
#
##MIGHT AS WELL TRY THIS LATE. Will still like to thank NancokALT for helping me a bit
#var dir:=Directory.new()
#const SAVE_FOLDER = "user://Scenes/"
#var SAVE_FILE = "user://Scenes/save_file.save"
#var g_data = {
##		"current_level": SceneManager.scene,
##		"lives": 0
#}
#
#func _init():
#	dir.make_dir(SAVE_FOLDER)
#
#func save_data():
#	var file = File.new()
#	file.open(SAVE_FILE + "save.sav" , file.WRITE_READ)
#	file.store_var(g_data)
#	file.close()
#	var newPacked:=PackedScene.new()
#	newPacked.pack(get_tree().current_scene)
#	ResourceSaver.save(SAVE_FILE +"current_scene.tscn", newPacked)
##	return
#
#func load_data():
#	var file = File.new()
#	if not file.file_exists(SAVE_FILE):
#		g_data = {
#			"lives": 0
#		}
#		save_data()
#	file.open(SAVE_FILE + "save.sav" , file.WRITE_READ)
#	g_data = file.get_var()
#	get_tree().change_scene(SAVE_FILE + "current_scene.tscn")
##	file.close
#
#
##file.load(SAVE_FILE + "save.sav" , file.WRITE_READ)
