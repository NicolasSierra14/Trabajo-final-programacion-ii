extends Enemigo

func _ready():
	color_enemigo = "rojo"
	direccion.x = -1

func _physics_process(delta):
	velocity.x = direccion.x * speed
	velocity.y += gravity * delta
	move_and_slide()
