extends Node


var dir:=Directory.new()
const SAVE_FOLDER = "user://Scenes/"
var SAVE_FILE = "user://Scenes/save_file.save"
var g_data = {
#		"current_level": SceneManager.scene,
#		"lives": 0
}

func _init():
	dir.make_dir(SAVE_FOLDER)

func save_data():
	var file = File.new()
	file.open(SAVE_FOLDER, file.WRITE)
	file.store_var(g_data)
	file.close()
#	return

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		g_data = {
			"current_level": SceneManager.scene,
			"lives": 0
		}
		save_data()
	file.load(SAVE_FILE, File.READ)
	g_data = file.get_var()
#	file.close
