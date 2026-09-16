extends Entidad
class_name Enemigo
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var color_enemigo : String

func morir_enemigo():
	queue_free()
