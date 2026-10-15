extends Area2D
@export var animacion_disparo_enemigo_rojo : AnimatedSprite2D

var direccion : Vector2
var velocidad : float = 150

func _physics_process(delta):
	animacion_disparo_enemigo_rojo.play()
	position += direccion * velocidad * delta

func _on_body_entered(body):
	if body is Enemigo:
		return
	if body is Player:
		body.vida -= 10
	queue_free()
