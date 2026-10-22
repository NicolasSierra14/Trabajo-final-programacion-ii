extends Entidad
class_name Enemigo
## Es la clase base para los Enemigos del juego. Al heredar de Entidad, aprovecha el cálculo de movimiento horizontal y gravedad vertical. Incorpora la identificación cromática del enemigo y gestiona la recepción de daño y su ciclo de destrucción al quedarse sin puntos de salud.

## Vinculo con su sprite correspondiente.
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

## Cadena expuesta al Inspector de Godot que define el color del enemigo (por ejemplo: "Rojo", "Azul", "Amarillo", "Violeta", etc.), utilizada para comprobar si una poción arrojada debe infligirle daño.
@export var color_enemigo : String

## Magnitud base de aceleración o fuerza vertical empleada durante el cálculo del arco parabólico.
var velocidad_vertical : float = 150.0

## Almacena la cota vertical inicial en el eje Y al crearse el enemigo, usada como límite superior para el clamp de retorno.
@onready var max_height = position.y

## Duración total en segundos de una parábola.
var tiempo : float = 0.5

## Booleano de control que determina si la fase activa de desplazamiento parabólico se está ejecutando o si debe frenarse.
var moving = true

## Acumulador de tiempo en segundos (incrementado con delta) que rastrea el avance del ciclo de movimiento parabólico.
var contador : float = 0

## Resta salud al enemigo y comprueba si el impacto provoca su muerte.
func daño_recibido_enemigo(cantidad:int):
	vida -= cantidad
	if vida <= 0:
		Muerte()

## Selector expuesto en el Inspector de Godot que define el modo de desplazamiento.
@export_enum("vertical","parabolico","horizontal") var movement_type : String = "vertical"

## Bucle de físicas principal que evalúa y ejecuta el tipo de movimiento seleccionado en movement_type.
func _physics_process(delta):
	match movement_type:
		"vertical":
			pass
		"horizontal":
			if direccion.x < 0:
				animated_sprite.flip_h = false
			else:
				animated_sprite.flip_h = true
			velocity.x = direccion.x * speed
			velocity.y += gravity * delta
			move_and_slide()
		"parabolico":
			if moving:
				velocity.x = (speed/tiempo) * direccion.x
				contador += delta
			if contador <= tiempo / 2.0:
				velocity.y = (velocidad_vertical/(tiempo*tiempo)) * abs(contador - (tiempo/2))
			else:
				velocity.y = -(velocidad_vertical/(tiempo*tiempo)) * abs(contador - (tiempo/2))
			if contador >= tiempo:
				contador = 0.0
				direccion.x *= -1
				$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
				moving = false
				position.y = clamp(position.y,max_height,INF)
			else:
				velocity = Vector2.ZERO
				move_and_slide()
