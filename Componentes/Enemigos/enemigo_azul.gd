extends Enemigo
class_name Enemigo_Azul
## Tipo de Enemigo Azul que se mueve de manera horizontal.

@export var cambio_de_lado_enemigo_azul : Timer 
## Referencia al nodo Timer asignado desde el Inspector, encargado de marcar los intervalos de tiempo en los que el enemigo debe darse la vuelta e invertir su patrullaje.

## Configura el estado inicial del enemigo al entrar al árbol de escenas.
func _ready():
	color_enemigo = "Azul" 
	direccion.x = -1

## Señal ejecutada automáticamente cada vez que finaliza el temporizador de patrulla.
func _on_cambio_de_lado_azul_timeout():
	direccion.x *= -1
