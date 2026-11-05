extends Control
@export var escena_juego : PackedScene
@export var opcciones_menu : PanelContainer


func _on_s_alir_pressed():
	get_tree().quit()


func _on_comenzar_juego_pressed():
	get_tree().change_scene_to_packed(escena_juego)


func _on_opccion_pressed():
	opcciones_menu.show()


func _on_boton_cierra_opcciones_pressed():
	opcciones_menu.hide()


func _on_cargar_juego_pressed():
	get_tree().change_scene_to_packed(escena_juego)
