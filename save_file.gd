extends Node

const SAVE_FILE = "user://save_file.save"
var g_data = {}

func _ready():
	pass

func save_data():
	var file = File.new()
	file.open(SAVE_FILE, file.WRITE)
	file.store_var(g_data)
	file.close()

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		g_data = {
			"current_level": SceneManager.scene,
			"lives": 0
		}
		save_data()
	file.open(SAVE_FILE, File.READ)
	g_data = file.get_var()
#	file.close
