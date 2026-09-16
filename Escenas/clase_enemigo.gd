extends Entidad
class_name Enemigo
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var color_enemigo : String

func daño_recibido_enemigo(cantidad:int):
	vida -= cantidad
	if vida <= 0:
		Muerte()

func morir_enemigo():
	queue_free()
