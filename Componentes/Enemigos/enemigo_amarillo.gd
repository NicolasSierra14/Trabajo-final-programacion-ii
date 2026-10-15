extends Enemigo
var tiempo : float = 0.5
var velocidad_vertical : float = 150.0

@onready var max_height = position.y 
func _ready():
	color_enemigo = "Amarillo"
	direccion.x = -1

var moving = true

var contador : float = 0
func _physics_process(delta):
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

func hacer_saltito():
	moving = true
