extends Area2D
@export var animacion_disparo_enemigo_rojo : AnimatedSprite2D

var direccion : Vector2
var velocidad : float = 150

func _physics_process(delta):
	animacion_disparo_enemigo_rojo.play()
	position += direccion * velocidad * delta
	for objeto in get_overlapping_bodies():
		if objeto is Player:
			queue_free()
