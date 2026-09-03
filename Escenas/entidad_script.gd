extends CharacterBody2D
class_name Entidad

@export var vida : int
#var Maquina de Estado
@export var speed : float
@export var gravity : float 
var direccion : Vector2

func process_move(delta):
	if not is_on_floor():
		velocity.y += gravity * get_physics_process_delta_time()
	else:
		if velocity.y > 0:
			velocity.y = 0.0
	velocity.x = direccion.x * speed
	move_and_slide()




func Muerte():
	queue_free()

func _physics_process(delta):
	process_move(delta)
