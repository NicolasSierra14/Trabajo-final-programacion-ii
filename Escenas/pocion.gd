extends CharacterBody2D
class_name Pocion

@export var tipo_color : String = ""
var velocidad : float = 600.0
var direccion : Vector2 = Vector2.RIGHT
var gravedad : float = 980.0
var velocidad_horizontal : float = 600.0
var velocidad_inicial_vertical : float = -300.0
var daño_pocion : float = 100
@onready var sprite_pocion = $SpritePocion
@export var colison_color_enemigo : Area2D

var lanzada : bool = false

func _process(delta):
	actualizar_visual_pocion()
	velocity.y += gravedad * delta
	move_and_slide()


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


func _on_area_2d_body_entered(body):
	if body is Player:
		return
	
	if body is Enemigo:
		if body.color_enemigo == tipo_color:
			body.daño_recibido_enemigo(daño_pocion)
		queue_free()
