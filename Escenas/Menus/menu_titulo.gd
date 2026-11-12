## Gestiona la interfaz de usuario de la pantalla de inicio del juego.
extends Control

## Referencia a la escena principal del nivel.
@export var escena_juego : PackedScene

## Referencia al contenedor de la interfaz de opciones, permitiendo mostrarlo u ocultarlo según las acciones del usuario.
@export var opcciones_menu : PanelContainer

## Cierra la aplicación del juego por completo.
func _on_s_alir_pressed():
	get_tree().quit()

## Inicia una partida nueva cambiando a la escena de juego.
func _on_comenzar_juego_pressed():
	get_tree().change_scene_to_packed(escena_juego)

## Muestra el panel de configuración u opciones.
func _on_opccion_pressed():
	opcciones_menu.show()

## Cierra u oculta el panel de opciones.
func _on_boton_cierra_opcciones_pressed():
	opcciones_menu.hide()


##func _on_cargar_juego_pressed():
##	get_tree().change_scene_to_packed(escena_juego)
