extends Area2D

class_name Disparo_Enemigo_Rojo
## Sistema de movimeinto y animacion del Dispar hecho por el Enemigo Rojo.

## Vinculacion con el sprite
@export var animacion_disparo_enemigo_rojo : AnimatedSprite2D

## Vector que determina el sentido y trayectoria hacia donde viaja la bala.
var direccion : Vector2

## Rapidez constante de desplazamiento lineal de la bala en píxeles por segundo.
var velocidad : float = 150

## Bucle físico que mantiene activa la animación y traslada el proyectil en el espacio.
func _physics_process(delta):
	animacion_disparo_enemigo_rojo.play()
	position += direccion * velocidad * delta

## Señal emitida cuando un cuerpo físico entra en el área de colisión del proyectil.
func _on_body_entered(body):
	if body is Enemigo:
		return
	if body is Player:
		body.vida -= 10
	queue_free()
