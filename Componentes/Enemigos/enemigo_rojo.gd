extends Enemigo
@export var cambio_de_lado_enemigo_rojo : Timer 
@export var escena_bala_enemigo_rojo : PackedScene
@export var area_vision_enemigo_rojo : Area2D
@export var timepo_de_disparo : Timer

func _ready():
	color_enemigo = "Rojo"
	direccion.x = -1

func _physics_process(delta):
	if direccion.x < 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	velocity.x = direccion.x * speed
	velocity.y += gravity * delta
	move_and_slide()



func _on_cambio_de_lado_enemigo_rojo_timeout():
	direccion.x *= -1

func crear_bala(direccion : Vector2):
	var bala_enemigo_rojo = escena_bala_enemigo_rojo.instantiate()
	if direccion.x < 0:
		bala_enemigo_rojo.get_node("AnimatedSprite2D").flip_h = true
	else:
		bala_enemigo_rojo.get_node("AnimatedSprite2D").flip_h = false
	get_parent().add_child(bala_enemigo_rojo)
	bala_enemigo_rojo.position = position
	bala_enemigo_rojo.direccion = direccion



func _on_area_de_vision_body_entered(body):
	if body is Player:
		print("Player dentro del area")
		crear_bala(position.direction_to(body.position))
		if timepo_de_disparo.is_stopped():
			timepo_de_disparo.start()

func _on_tiempo_de_disparo_timeout():
	crear_bala(direccion)
