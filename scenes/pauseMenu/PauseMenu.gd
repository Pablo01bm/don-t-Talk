extends Control

@onready var main = $"../../"

func _on_reanudar_pressed():
	main.pause_menu_action()


func _on_salir_pressed():
	get_tree().change_scene_to_file("res://scenes/mainMenu/mainMenu.tscn")
