extends Enemigo
class_name Enemigo_Amarillo
## Tipo de enemigo Amarillo que se mueve de manera parabolica.

## ## Configura el estado inicial del enemigo al entrar al árbol de escenas.
func _ready():
	color_enemigo = "Amarillo"
	direccion.x = -1

## Tras terminar el contador, el movimeinto parabolico es activado.
func hacer_saltito():
	moving = true
