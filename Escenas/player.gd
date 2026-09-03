extends Entidad
class_name Player
@export var color_actual : String = ""
@export var color_secundario : String = ""
var escena_pocion = preload("res://Escenas/pocion.tscn")
var instancia : Pocion


func _physics_process(delta):
	var direccion_x = Input.get_axis("Izquierda", "Derecha")
	direccion = Vector2(direccion_x, 0)
	
	if is_on_floor() and Input.is_action_just_pressed("Saltar"):
		velocity.y = -1000.0 # Impulso inicial hacia arriba
	super._physics_process(delta)
	
	gestionar_colores()
	
	if Input.is_action_just_pressed("Lanzar"):
		lanzar_pocion()

	super._physics_process(delta)


func gestionar_colores():
	if Input.is_action_just_pressed("Rojo"):
		print("Tecla 1 presionada")
		seleccionar_o_combinar("Rojo")
		crear_instancia_pocion(color_actual)
	elif Input.is_action_just_pressed("Azul"):
		print("Tecla 2 presionada")
		seleccionar_o_combinar("Azul")
		crear_instancia_pocion(color_actual)
	elif Input.is_action_just_pressed("Amarillo"):
		print("Tecla 3 presionada")
		seleccionar_o_combinar("Amarillo")
		crear_instancia_pocion(color_actual)

func crear_instancia_pocion(color):
	if instancia:
		if not instancia.lanzada:
			instancia.queue_free()
	instancia = escena_pocion.instantiate()
	instancia.tipo_color = color
	add_child(instancia)

func seleccionar_o_combinar(nuevo_color: String):
	if color_actual == "":
		color_actual = nuevo_color
	elif color_secundario == "" and color_actual != nuevo_color:
		color_secundario = nuevo_color
		combinar_colores()

func combinar_colores():
	var combinacion = [color_actual, color_secundario]
	combinacion.sort()
	
	if combinacion == ["Azul", "Rojo"]:
		color_actual = "Violeta"
	elif combinacion == ["Amarillo", "Rojo"]:
		color_actual = "Naranja"
	elif combinacion == ["Amarillo", "Azul"]:
		color_actual = "Verde"
	
	color_secundario = ""
	print("¡Combinación exitosa! Poción resultante: ", color_actual)
	color_secundario = ""



func lanzar_pocion():
	print("La variable global es ", color_actual)
	print("Se lanzo la pocion: ", color_actual)
	if color_actual != "":
		color_actual = ""
		color_secundario = ""
	if instancia:
		if instancia.lanzada: return
		instancia.lanzada = true
		instancia.reparent(get_tree().current_scene)
		instancia.movimiento_pocion()
