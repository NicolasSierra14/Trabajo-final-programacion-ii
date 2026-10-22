extends CharacterBody2D
class_name Entidad
## Es la clase base del juego para cualquier personaje u objeto con físicas y desplazamiento. Proporciona la estructura común de movimiento, aplicación de gravedad, control de estados físicos y vida, sirviendo de plantilla el Player y los Enemigos.

## Almacena los puntos de salud de la Entidad. Es editable desde el Inspector de Godot.
@export var vida : int

## Determina la velocidad máxima de desplazamiento horizontal que alcanzará el cuerpo al moverse.
@export var speed : float

## Valor de aceleración vertical aplicado para simular la caída física por gravedad cuando la entidad no toca el suelo. Es editable desde el Inspector de Godot.
@export var gravity : float 

## Vector que define el sentido y la dirección hacia donde se desplaza la Entidad.
var direccion : Vector2

## Ejecuta el movimiento físico general del cuerpo y la gravedad de los cuerpos. 
func process_move(delta):
	if not is_on_floor():
		velocity.y += gravity * get_physics_process_delta_time()
	else:
		if velocity.y > 0:
			velocity.y = 0.0
	velocity.x = direccion.x * speed
	move_and_slide()

## Gestiona la eliminación de la entidad del juego.
func Muerte():
	queue_free()

func _physics_process(delta):
	process_move(delta)
