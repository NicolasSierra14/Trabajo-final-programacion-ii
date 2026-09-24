extends CharacterBody2D
class_name Pocion

@export var tipo_color : String = ""
var velocidad : float = 600.0
var direccion : Vector2 = Vector2.RIGHT
var gravedad : float = 980.0
var velocidad_horizontal : float = 300.0
var velocidad_inicial_vertical : float = -150.0
var daño_pocion : float = 100
@onready var sprite_pocion = $SpritePocion
@export var area : Area2D

var lanzada : bool = false

func _physics_process(delta):
	actualizar_visual_pocion()
	if lanzada:
		velocity.y += gravedad * delta
		move_and_slide()
	for body in area.get_overlapping_bodies():
		if body is StaticBody2D or body is TileMapLayer:
			queue_free()
		if body is Enemigo:
			if body.color_enemigo == tipo_color:
				body.daño_recibido_enemigo(daño_pocion)
			queue_free()

func actualizar_visual_pocion():
		if tipo_color == "Rojo":
			sprite_pocion.play("rojo")
		elif tipo_color== "Azul":
			sprite_pocion.play("azul")
		elif tipo_color == "Amarillo":
			sprite_pocion.play("amarillo")
		elif tipo_color == "Violeta":
			sprite_pocion.play("violeta")
		elif tipo_color == "Naranja":
			sprite_pocion.play("naranja")
		elif tipo_color == "Verde":
			sprite_pocion.play("verde")

func movimiento_pocion():
	velocity = Vector2(50,50)
	velocity.x = direccion.x * velocidad_horizontal
	velocity.y = velocidad_inicial_vertical
