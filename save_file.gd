extends Node

const SAVE_FILE = "user://save_file.save"
var g_data = {}

func _ready():
	pass

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		g_data = {
			"current_level": 0,
			"lives": 0
		}
