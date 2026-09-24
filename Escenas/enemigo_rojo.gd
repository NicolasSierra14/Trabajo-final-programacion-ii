extends Enemigo
@export var cambio_de_lado_enemigo_rojo : Timer 

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
