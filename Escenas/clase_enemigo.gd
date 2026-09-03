extends Entidad
class_name Enemigo
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var color_enemigo : String 

func _ready():
	vida = 100
	speed = 300
	gravity = 2500

func morir_enemigo():
	queue_free()
