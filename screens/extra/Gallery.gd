extends Control

#In case i get lots of art that could fill this gallery
#And i learn how to do a proper "slide" style of mechanism to switch between images

func _ready():
	pass

func _on_TextureButton_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/MainMenu.tscn")


func _on_NORTUBEL_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/extra/GalleryMenu Nortubel.tscn")


func _on_HIRDRIH_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/extra/GalleryMenu Hirdrih.tscn")


func _on_MASSAGCOAV_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/extra/GalleryMenu MassagCoav.tscn")


func _on_BRINKAEDEA_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/extra/GalleryMenu Brinkaedea.tscn")


func _on_OTHER_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/extra/GalleryMenu Other.tscn")

func _on_KRIMBSTONE_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/extra/GalleryMenu Krimbstone.tscn")


func _on_LAHIURN_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/extra/GalleryMenu Lahiurn.tscn")


func _on_UNTOTERN_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/extra/GalleryMenu Untotern.tscn")

func _on_HERRKO_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/extra/GalleryMenu Herrko.tscn")

func _on_GREKLOVICK_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/extra/GalleryMenu Greklovick.tscn")



