extends Enemigo
class_name Enemigo_Rojo
## Tipo de Enemigo Rojo que se mueve de manera horizontal y dispara si detecta al Player.

## Nodo temporizador que define los intervalos periódicos para invertir el sentido de la marcha durante el patrullaje.
@export var cambio_de_lado_enemigo_rojo : Timer 

## Escena del proyectil precargada.
@export var escena_bala_enemigo_rojo : PackedScene

## Nodo de detección por área encargado de registrar cuándo el jugador entra en su rango de alcance.
@export var area_vision_enemigo_rojo : Area2D

## Nodo temporizador que controla la cadencia o intervalo entre ráfagas continuas de disparos mientras el objetivo permanezca en la zona de ataque.
@export var timepo_de_disparo : Timer

## Configura el estado inicial del enemigo al entrar al árbol de escenas.
func _ready():
	color_enemigo = "Rojo"
	direccion.x = -1

## Bucle de físicas que resuelve la orientación del sprite y el desplazamiento terrestre.
func _physics_process(delta):
	if direccion.x < 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	velocity.x = direccion.x * speed
	velocity.y += gravity * delta
	move_and_slide()

## Señal conectada al temporizador de patrullaje.
func _on_cambio_de_lado_enemigo_rojo_timeout():
	direccion.x *= -1

## Instancia, orienta y posiciona el proyectil en la escena.
func crear_bala (dir: Vector2):
	var bala_enemigo_rojo = escena_bala_enemigo_rojo.instantiate()
	if direccion.x < 0:
		bala_enemigo_rojo.get_node("AnimatedSprite2D").flip_h = true
	else:
		bala_enemigo_rojo.get_node("AnimatedSprite2D").flip_h = false
	get_parent().add_child(bala_enemigo_rojo)
	bala_enemigo_rojo.position = position
	bala_enemigo_rojo.direccion = direccion

## Señal recibida cuando un cuerpo entra en el Area2D de visión.
func _on_area_de_vision_body_entered(body):
	if body is Player:
		print("Player dentro del area")
		crear_bala(position.direction_to(body.position))
		if timepo_de_disparo.is_stopped():
			timepo_de_disparo.start()

## Señal cíclica emitida por el temporizador de recarga de disparo.
func _on_tiempo_de_disparo_timeout():
	crear_bala(direccion)
