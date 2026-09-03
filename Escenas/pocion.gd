extends CharacterBody2D
class_name Pocion

@export var tipo_color : String = ""
var velocidad : float = 600.0
var direccion : Vector2 = Vector2.ZERO
@onready var sprite_pocion = $SpritePocion


func _process(delta):
	actualizar_visual_pocion()

func actualizar_visual_pocion():
		if VariablesGlobales.sprite_pocion_actual == "Rojo":
			sprite_pocion.play("rojo")
			print("Es la pocion roja sprite")
		elif VariablesGlobales.sprite_pocion_actual== "Azul":
			sprite_pocion.play("azul")
		elif VariablesGlobales.sprite_pocion_actual == "Amarillo":
			sprite_pocion.play("amarillo")
		elif VariablesGlobales.sprite_pocion_actual == "Violeta":
			sprite_pocion.play("violeta")
		elif VariablesGlobales.sprite_pocion_actual == "Naranja":
			sprite_pocion.play("naranja")
		elif VariablesGlobales.sprite_pocion_actual == "Verde":
			sprite_pocion.play("verde")
